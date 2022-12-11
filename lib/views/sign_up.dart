import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:on_duty/views/login.dart';
import 'package:on_duty/widgets/app_alerts.dart';
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
  final _auth = FirebaseAuth.instance;
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;
  bool isLoading = false;

  void onTapClickMe(BuildContext context) {
    Navigator.of(context).push(
      PageTransition(
        child: const LoginScreen(),
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
            const SizedBox(height: 40),
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
                          controller: _firstnameController,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: AppForm.appTextFormField(
                          label: "Soyisim",
                          hint: "Temiz",
                          controller: _lastnameController,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
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
                  const SizedBox(height: 16),
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
                              decoration: TextDecoration.underline,
                            ),
                            children: [
                              const TextSpan(
                                text: " ve",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.4,
                                  color: AppColors.lightPrimary,
                                  decoration: TextDecoration.none,
                                ),
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
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: signUp,
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: AppColors.lightSecondary,
                                strokeWidth: 3,
                              ),
                            )
                          : const Text("Kaydol"),
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void signUp() async {
    if (_formKey.currentState!.validate()) {
      if (isChecked) {
        setState(() => isLoading = true);
        _auth.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        ).then((value) => {
          setState(() => isLoading = false),
          Navigator.pushReplacementNamed(context, 'home_screen'),
          AppAlerts.toast(message: "Başarıyla giriş yapıldı."),
        }).catchError((e) => {
          setState(() => isLoading = false),
          if (e.code == 'email-already-in-use') {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                padding: EdgeInsets.all(20),
                content: Text("Bu email zaten kullanılmaktadır."),
                duration: Duration(milliseconds: 1500),
              ),
            ),
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                padding: const EdgeInsets.all(20),
                content: Text(e.toString()),
                duration: const Duration(milliseconds: 1500),
              ),
            ),
          },
        });
      } else {
        setState(() => isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            padding: EdgeInsets.all(20),
            content: Text("Kaydolmak için kutucuğu işaretleyiniz."),
            duration: Duration(milliseconds: 1500),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
