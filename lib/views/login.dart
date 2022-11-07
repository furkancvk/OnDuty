import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const Text("Login Screen"),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, "sign_up_screen"),
              child: const Text("Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}
