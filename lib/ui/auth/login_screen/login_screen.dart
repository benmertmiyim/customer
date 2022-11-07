import 'package:customer/core/view/auth_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String email = "";
    String password = "";

    return Scaffold(
      backgroundColor: const Color(0xffF7EBE1),
      body:           Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 35, top: 130),
                child: const Text(
                  'Welcome\nBack',
                  style: TextStyle( fontSize: 33),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 35, right: 35),
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter email';
                        } else {
                          email = value;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        } else {
                          password = value;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: "Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Sign in',
                          style: TextStyle(
                              fontSize: 27, fontWeight: FontWeight.w700),
                        ),
                        Consumer<AuthView>(
                          builder: (BuildContext context, value,
                              Widget? child) {
                            if (value.authProcess == AuthProcess.idle) {
                              return CircleAvatar(
                                radius: 30,
                                backgroundColor: const Color(0xff4c505b),
                                child: IconButton(
                                    color: Colors.white,
                                    onPressed: () async {
                                      if (formKey.currentState!
                                          .validate()) {
                                        await value.signInWithEmailAndPassword(
                                            email, password).then((customer){
                                          if(value.customer == null){
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'Email or passwrod is wrong!'),),
                                            );
                                          }
                                        });

                                      }
                                    },
                                    icon: const Icon(
                                      Icons.arrow_forward,
                                    )),
                              );
                            } else {
                              return const CircularProgressIndicator();
                            }
                          },
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'register');
                          },
                          style: const ButtonStyle(),
                          child: const Text(
                            'Sign Up',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Color(0xff4c505b),
                                fontSize: 18),
                          ),
                        ),
                        TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Forgot Password',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Color(0xff4c505b),
                                fontSize: 18,
                              ),
                            )),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
