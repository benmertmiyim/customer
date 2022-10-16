import 'package:customer/core/view/auth_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthView authView = Provider.of<AuthView>(context);
    return Scaffold(
        body: Center(
      child: ElevatedButton(
        child: const Text("Login"),
        onPressed: () {
          authView.signInWithEmailAndPassword(
              "benmertmiyim35@gmail.com", "159263.Mert");
        },
      ),
    ));
  }
}
