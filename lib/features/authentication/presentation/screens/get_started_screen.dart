import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xrpay/config/common/common_widgets.dart';
import 'package:xrpay/core/routes/routes.dart';
import 'package:xrpay/injection_container.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              child: _appInfo()
            ),
          ],
        ),
      ),
    );
  }

  Widget _appInfo() {
    return Column(
      children: [
        Text("Track Your Spending Effortlessly", style: Theme.of(context).textTheme.headlineLarge,),
        12.ph,
        Container(
          child: Text(
            "Manage your finances easily using our intuitive and user-friendly interface and set financial goals and monitor your progress",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        16.ph,
        _signUpButton(),
        12.ph,
        _loginText(),
        40.ph
      ],
    );
  }

  Widget _signUpButton() {
    return GestureDetector(
      onTap: () {
        sl<NavigationService>().pushTo("/signUp");
      },
      child: Container(
        height: 40.h,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(18.r)
        ),
        child: Text("Get Started", style: Theme.of(context).textTheme.labelLarge, textAlign: TextAlign.center,),
      ),
    );
  }

  Widget _loginText() {
    return RichText(
      text: TextSpan(
        style: TextStyle(color: Colors.white, fontSize: 16.sp),
        children: [
          const TextSpan(text: "Already have an account? "),
          TextSpan(
            text: "Login",
            style: const TextStyle(fontWeight: FontWeight.bold),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                sl<NavigationService>().pushTo("/login");
              },
          ),
        ],
      ),
    );
  }
}