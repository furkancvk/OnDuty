import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("LogIn Page"),
        ElevatedButton(
          child: Text(" LogIn"),
          onPressed: () {
            Navigator.pushNamed(context, "home_screen");
          },
        ),
      ],
    );
  }
}
