import 'package:customer/core/view/auth_view.dart';
import 'package:customer/ui/auth/forgot_password_screen/forgot_password_screen.dart';
import 'package:customer/ui/auth/login_screen/login_screen.dart';
import 'package:customer/ui/auth/register_screen/register_screen.dart';
import 'package:customer/ui/introduction_animation/introduction_animation_screen.dart';
import 'package:customer/ui/main/main_screen.dart';
import 'package:customer/ui/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthView authView = Provider.of<AuthView>(context);

    if (authView.authState == AuthState.landing) {
      return const SplashScreen();
    } else {
      if (authView.authState == AuthState.intro) {
        return const IntroductionAnimationScreen();
      } else if (authView.authState == AuthState.signIn) {
        return const LoginScreen();
      } else if (authView.authState == AuthState.signUp) {
        return const RegisterScreen();
      } else if (authView.authState == AuthState.forgot) {
        return const ForgotPasswordScreen();
      } else {
        return const MainScreen();
      }
    }
  }
}
