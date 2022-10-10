import 'package:customer/const.dart';
import 'package:customer/core/view/auth_view.dart';
import 'package:customer/core/view/location_view.dart';
import 'package:customer/core/view/park_view.dart';
import 'package:customer/firebase_options.dart';
import 'package:customer/locator.dart';
import 'package:customer/ui/landing_screen.dart';
import 'package:customer/ui/main/main_screen.dart';
import 'package:customer/ui/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  runApp(const MyApp());
  setUpLocator();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthView(),
        ),
        ChangeNotifierProvider(
          create: (context) => ParkView(),
        ),
        ChangeNotifierProvider(
          create: (context) => LocationView(),
        ),
      ],
      child: MaterialApp(
        title: title,
        debugShowCheckedModeBanner: debugMode,
        theme: ThemeData(
          primarySwatch: primaryColor,
          scaffoldBackgroundColor: backgroundColor,
        ),
        home: const MainScreen(),
      ),
    );
  }
}
