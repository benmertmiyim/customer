import 'package:customer/core/view/auth_view.dart';
import 'package:customer/ui/auth/login_screen/login_screen.dart';
import 'package:customer/ui/auth/register/register.dart';
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


    if(authView.authState == AuthState.landing){
      return const IntroductionAnimationScreen();
    }else{
      if(authView.authState == AuthState.unAuthorized){
        return const RegisterScreen();
      }else{
        return const MainScreen();
      }
    }
  }
}
