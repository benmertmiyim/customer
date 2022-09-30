import 'package:customer/const.dart';
import 'package:customer/core/view/auth_view.dart';
import 'package:customer/ui/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
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
