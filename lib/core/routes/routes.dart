import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xrpay/features/authentication/presentation/screens/get_started_screen.dart';
import 'package:xrpay/features/authentication/presentation/screens/login_screen.dart';
import 'package:xrpay/features/authentication/presentation/screens/signup_screen.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  pushTo(String route, {dynamic arguments}) {
    return navigationKey.currentState!.pushNamed(route, arguments: arguments);
  }

  pop({dynamic arguments}) {
    return navigationKey.currentState!.pop(arguments);
  }

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => const GetStartedScreen());
      case "/signUp":
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case "/login":
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      default:
        return MaterialPageRoute(builder: ((context) {
          return const Scaffold(
            body: Center(
              child: Text("Error"),
            ),
          );
        }));
    }
  }
}