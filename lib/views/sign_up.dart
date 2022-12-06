import 'package:flutter/material.dart';
import 'package:on_duty/views/login.dart';
import 'package:page_transition/page_transition.dart';

import '../design/app_colors.dart';
import '../design/app_text.dart';
import '../widgets/app_form.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
                  Text("Hesabını Oluştur", style: AppText.titleSemiBold),
                  const SizedBox(height: 8),
                  Text(
                    "Lütfen tüm bilgileri eksiksiz giriniz.",
                    style: AppText.context,
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: AppForm.appTextFormField(
                          label: "İsim",
                          hint: "Ahmet",
                          controller: TextEditingController(),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: AppForm.appTextFormField(
                          label: "Soyisim",
                          hint: "Temiz",
                          controller: TextEditingController(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
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
                      Expanded(
                        flex: 1,
                        child: Checkbox(
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        flex: 9,
                        child: RichText(
                          text: TextSpan(
                              text: "Gizlilik",
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.4,
                                  color: AppColors.lightPrimary,
                                  decoration: TextDecoration.underline),
                              children: [
                                const TextSpan(
                                  text: " ve",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0.4,
                                      color: AppColors.lightPrimary,
                                      decoration: TextDecoration.none),
                                ),
                                TextSpan(
                                  text: " veri yönetimi sözleşmesini",
                                  style: AppText.labelSemiBold,
                                ),
                                const TextSpan(
                                  text: " okudum ve kabul ediyorum",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0.4,
                                      color: AppColors.lightPrimary,
                                      decoration: TextDecoration.none),
                                ),
                              ]),
                        ),
                      )
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
                  FittedBox(
                    child: Wrap(
                      children: [
                        Text(
                          "Zaten hesabınız var mı? Giriş yapmak için ",
                          style: AppText.context,
                        ),
                        GestureDetector(
                          onTap: () => {
                            Navigator.of(context).push(PageTransition(
                                child: LoginScreen(),
                                duration: Duration(milliseconds: 400),
                                type: PageTransitionType.rightToLeft)),
                          },
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
