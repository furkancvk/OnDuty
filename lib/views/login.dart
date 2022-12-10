import 'package:flutter/material.dart';
import 'package:on_duty/views/sign_up.dart';
import 'package:on_duty/widgets/app_form.dart';
import 'package:page_transition/page_transition.dart';

import '../design/app_colors.dart';
import '../design/app_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;
  bool isLoading = false;

  void onTapClickMe(BuildContext context) {
    Navigator.of(context).push(
      PageTransition(
        child: const SignUpScreen(),
        duration: const Duration(milliseconds: 400),
        type: PageTransitionType.rightToLeft,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          addAutomaticKeepAlives: false,
          padding: const EdgeInsets.all(24),
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset("assets/images/logo-onduty.png", height: 50),
            ),
            const SizedBox(height: 80),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Text("Hoş Geldiniz", style: AppText.titleSemiBold),
                  const SizedBox(height: 8),
                  Text(
                    "Giriş yapmak için email & şifrenizi giriniz.",
                    style: AppText.context,
                  ),
                  const SizedBox(height: 32),
                  AppForm.appTextFormField(
                    label: "Email",
                    hint: "isminiz@domain.com",
                    controller: _emailController,
                    isEmail: true,
                  ),
                  const SizedBox(height: 24),
                  PasswordFieldWithVisibility(
                    controller: _passwordController,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Checkbox(
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                      Text("Beni Hatırla", style: AppText.label)
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: logIn,
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: AppColors.lightSecondary,
                                strokeWidth: 3,
                              ),
                            )
                          : const Text("Giriş Yap"),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Wrap(
                    children: [
                      Text(
                        "Hesabınız yok mu? Kaydolmak için ",
                        style: AppText.context,
                      ),
                      GestureDetector(
                        onTap: () => onTapClickMe(context),
                        child: const Text(
                          "tıklayın",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.4,
                            color: AppColors.lightPrimary,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void logIn() async {
    try {
      if (_formKey.currentState!.validate()) {
        /* await _auth.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        ); */
        Navigator.pushReplacementNamed(context, "home_screen");
        // AppAlerts.toast(message: "Başarılı bir şekilde giriş yapıldı");
        // setState(() => isLoading = false);
      }
    } /* on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            padding: const EdgeInsets.all(0),
            content: AppAlerts.appAlert(
              title: "No user found for that email",
              color: Colors.red,
              icon: const Icon(Icons.clear),
            ),
            duration: const Duration(milliseconds: 1500),
          ),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            padding: const EdgeInsets.all(0),
            content: AppAlerts.appAlert(
              title: "Wrong password provided for that user",
              color: Colors.red,
              icon: const Icon(Icons.clear),
            ),
            duration: const Duration(milliseconds: 1500),
          ),
        );
      }
    } */ catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          padding: const EdgeInsets.all(20),
          content: Text(e.toString()),
          duration: const Duration(milliseconds: 1500),
        ),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
