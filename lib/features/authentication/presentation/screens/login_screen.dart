import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xrpay/config/common/common_widgets.dart';
import 'package:xrpay/core/routes/routes.dart';
import 'package:xrpay/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:xrpay/features/authentication/presentation/widgets/textfield.dart';
import 'package:xrpay/injection_container.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  late TextEditingController _emailController;
  late TextEditingController _passwordController;


  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if(state.status == AuthenticationStatus.success) {
              //ToDo: Navigate to home screen
            }else if(state.status == AuthenticationStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error!,style: Theme.of(context).textTheme.labelMedium,), backgroundColor: Colors.red, duration: const Duration(seconds: 3),),
              );
            }
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 65.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _backButton(),
                10.ph,
                Text("Log In", style: Theme.of(context).textTheme.titleLarge,),
                5.ph,
                Text("Log In to access your account and transfer money", style: Theme.of(context).textTheme.titleSmall,),
                20.ph,
                _formView()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _backButton() {
    return GestureDetector(
      onTap: () {
        context.read<AuthenticationBloc>().add(ResetAuthStateEvent());
        sl<NavigationService>().pop();
      },
      child: Container(
        width: 32.w,
        height: 32.h,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey,
        ),
        alignment: Alignment.center,
        child: const Icon(Icons.arrow_back_ios_new, color: Colors.black,),
      ),
    );
  }

  Widget _formView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Email", style: Theme.of(context).textTheme.labelLarge,),
        5.ph,
        CustomTextField(
          controller: _emailController,
          errorMessage: "Please enter your email",
          hintText: "Email",
          prefixIcon: Icons.mail,
          onChanged: (value) {
            context.read<AuthenticationBloc>().add(UpdateEmailEvent(_emailController.text));
          },
        ),
        10.ph,
        Text("Password", style: Theme.of(context).textTheme.labelLarge,),
        5.ph,
        BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            return CustomTextField(
              controller: _passwordController,
              errorMessage: "Please enter your password",
              hintText: "Password",
              prefixIcon: Icons.lock,
              suffixIcon: GestureDetector(
                onTap: () {
                  context.read<AuthenticationBloc>().add(HideShowPasswordEvent());
                },
                child: state.obscureText ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
              ),
              obscureText: state.obscureText,
              onChanged: (value) {
                context.read<AuthenticationBloc>().add(UpdatePasswordEvent(_passwordController.text));
              },
            );
          },
        ),
        25.ph,
        BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            return GestureDetector(
              onTap: state.isFormValid ? () {
                final String email = _emailController.text;
                final String password = _passwordController.text;
                log("Details: $email $password");
                context.read<AuthenticationBloc>().add(LoginEvent());
              } : (){},
              child: Container(
                width: double.infinity,
                height: 34.h,
                decoration: BoxDecoration(
                    color: state.isFormValid ? Colors.blue : Colors.grey,
                    borderRadius: BorderRadius.circular(10.r)
                ),
                alignment: Alignment.center,
                child: Visibility(
                  visible: state.status != AuthenticationStatus.loading,
                  replacement: Container(
                    width: 28.w,
                    // color: Colors.red,
                    padding: EdgeInsets.symmetric(vertical: 6.h),
                    child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 4,),
                  ),
                  child: Text("Continue", style: Theme.of(context).textTheme.labelLarge, textAlign: TextAlign.center,),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}

