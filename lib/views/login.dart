import 'package:flutter/material.dart';
import 'package:on_duty/widgets/app_form.dart';

import '../design/app_colors.dart';
import '../design/app_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;

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
                    controller: TextEditingController(),
                  ),
                  const SizedBox(height: 24),
                  PasswordFieldWithVisibility(
                    controller: TextEditingController(),
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
                      onPressed: () => {},
                      child: const Text("Giriş Yap"),
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
                        onTap: () => Navigator.pushNamed(context, "sign_up_screen"),
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
}
