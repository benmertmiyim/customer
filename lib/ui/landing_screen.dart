import 'package:customer/core/view/auth_view.dart';
import 'package:customer/ui/auth/login_screen/login_screenn.dart';
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


    if(authView.authProcess == AuthProcess.idle){
      if(authView.customer == null){
        return const IntroductionAnimationScreen();
      }else{
        return const MainScreen();
      }
    }else{
      return const SplashScreen();
    }
  }
}
