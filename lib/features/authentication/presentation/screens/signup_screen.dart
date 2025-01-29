import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xrpay/config/common/common_widgets.dart';
import 'package:xrpay/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:xrpay/features/authentication/presentation/widgets/textfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;


  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Sign Up", style: Theme.of(context).textTheme.titleLarge,),
                5.ph,
                Text("Sign Up to access your account and transfer money", style: Theme.of(context).textTheme.titleSmall,),
                20.ph,
                _formView()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _formView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Name", style: Theme.of(context).textTheme.labelLarge,),
        5.ph,
        CustomTextField(
          controller: _nameController,
          errorMessage: "Please enter your name",
          hintText: "Name",
          prefixIcon: Icons.person,
          onChanged: (value) {
            context.read<AuthenticationBloc>().add(UpdateNameEvent(_nameController.text));
          },
        ),
        10.ph,
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
                final String name = _nameController.text;
                log("Details: $name $email $password");
                context.read<AuthenticationBloc>().add(SignUpEvent());
              } : (){},
              child: Container(
                width: double.infinity,
                height: 34.h,
                decoration: BoxDecoration(
                    color: state.isFormValid ? Colors.blue : Colors.grey,
                    borderRadius: BorderRadius.circular(10.r)
                ),
                alignment: Alignment.center,
                child: Text("Continue", style: Theme.of(context).textTheme.labelLarge, textAlign: TextAlign.center,),
              ),
            );
          },
        )
      ],
    );
  }
}

