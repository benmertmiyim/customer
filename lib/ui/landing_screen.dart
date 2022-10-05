import 'package:customer/core/view/auth_view.dart';
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
      return const MainScreen();
    }else{
      return const SplashScreen();
    }
  }
}
