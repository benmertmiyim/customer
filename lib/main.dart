import 'package:cloud_functions/cloud_functions.dart';
import 'package:customer/const.dart';
import 'package:customer/core/view/auth_view.dart';
import 'package:customer/core/view/banner_view.dart';
import 'package:customer/core/view/card_view.dart';
import 'package:customer/core/view/location_view.dart';
import 'package:customer/core/view/notification_view.dart';
import 'package:customer/core/view/park_view.dart';
import 'package:customer/firebase_options.dart';
import 'package:customer/locator.dart';
import 'package:customer/ui/landing_screen.dart';
import 'package:customer/ui/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  setUpLocator();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFunctions.instance.useFunctionsEmulator('localhost', 5001);//TODO

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BannerView(),
        ),
        ChangeNotifierProvider(
          create: (context) => CardView(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthView(),
        ),
        ChangeNotifierProvider(
          create: (context) => ParkView(),
        ),
        ChangeNotifierProvider(
          create: (context) => LocationView(),
        ),
        ChangeNotifierProvider(
          create: (context) => NotificationView(),
        ),
      ],
      child: MaterialApp(
        title: title,
        debugShowCheckedModeBanner: debugMode,
        theme: ThemeData(
          primarySwatch: primaryColor,
          scaffoldBackgroundColor: backgroundColor,
          fontFamily: "Baloo2",
        ),
        home: const LandingScreen(),
      ),
    );
  }
}
