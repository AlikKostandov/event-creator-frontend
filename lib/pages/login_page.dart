import 'package:event_creater/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:event_creater/widgets/stylized_field.dart';

import 'package:event_creater/widgets/header_widget.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final double _headerHeight = 250;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6E6E6),
      body: Stack(
        children: <Widget>[
          SizedBox(
            height: _headerHeight,
            child: HeaderWidget(
                _headerHeight), //let's create a common header widget
          ),
          Form(
            key: _formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Sign In',
                      style: TextStyle(
                          fontFamily: 'Lobster',
                          fontStyle: FontStyle.italic,
                          fontSize: 80.0,
                          wordSpacing: -20)),
                  Container(
                      margin: const EdgeInsets.only(
                          left: 30.0, right: 30.0, bottom: 30.0, top: 30),
                      child: StylizedField.withControllerAndValidator(
                          hintText: 'Email',
                          isObscure: false,
                          controller: _emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            } else {
                              if (!value.contains("@")) {
                                return 'Enter a valid email';
                              } else {
                                return null;
                              }
                            }
                          })),
                  Container(
                      margin: const EdgeInsets.only(
                          left: 30.0, right: 30.0, bottom: 30.0),
                      child: StylizedField.withControllerAndValidator(
                          hintText: 'Password',
                          isObscure: true,
                          controller: _passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            } else {
                              return null;
                            }
                          })),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment(0.8, 1.0),
                        colors: <Color>[
                          Color(0xff1f005c),
                          Color(0xff5b0060),
                          Color(0xff870160),
                          Color(0xffac255e),
                          Color(0xffca485c),
                          Color(0xffe16b5c),
                          Color(0xfff39060),
                          Color(0xffffb56b),
                        ],
                        tileMode: TileMode.mirror,
                      ),
                    ),
                    child: TextButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            await Auth().signInWithEmailAndPassword(
                                _emailController.value.text,
                                _passwordController.value.text);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Incorrect login or password')),
                              );
                            }
                          }
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 25.0),
                        child: Text(
                          "Finish".toUpperCase(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Montserrat',
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 8.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/registry');
                      },
                      child: Text(
                        'Registry'.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          letterSpacing: 5.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            try {
              await Auth().resetPassword(_emailController.text);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text(
                        'A link to restore your account has been sent to your email')),
              );
            } on FirebaseAuthException catch (e) {
              if (e.code == 'user-not-found' || e.code == 'invalid-email') {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text(
                          'Email is specified incorrectly or there is no such account')),
                );
              }
            }
          }
        },
        tooltip: 'Forgot password',
        backgroundColor: const Color(0xfff39060),
        child: const Icon(Icons.password),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
