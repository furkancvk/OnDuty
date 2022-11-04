import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("SignUp Page"),
        ElevatedButton(
          child: Text(" SignUp"),
          onPressed: () {
            Navigator.pushNamed(context, "home_screen");
          },
        ),
      ],
    );
  }
}
