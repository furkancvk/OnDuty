import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:on_duty/design/app_text.dart';
import 'package:on_duty/widgets/app_alerts.dart';
import 'package:on_duty/widgets/app_form.dart';

import '../design/app_colors.dart';

class ResetPasswordModal extends StatefulWidget {
  const ResetPasswordModal({Key? key}) : super(key: key);

  @override
  State<ResetPasswordModal> createState() => _ResetPasswordModalState();
}

class _ResetPasswordModalState extends State<ResetPasswordModal> {
  final _auth = FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Şifremi Değiştir",
        style: AppText.titleSemiBold,
      ),
      content: SizedBox(
          height: 200,
          child: Column(
            children: [
              Text(
                "Şifre değiştirmek için lütfen e-mailinizi girin size bir mail yollayacağız",
                style: AppText.label,
              ),
              SizedBox(
                height: 20,
              ),
              AppForm.appTextFormField(
                  label: "E-mail",
                  hint: "isminiz@domain.com",
                  controller: _emailController),
            ],
          )),
      actions: [
        OutlinedButton(
            onPressed: () {
              passwordReset();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  padding: EdgeInsets.all(0),
                  backgroundColor: AppColors.lightSecondary,
                  content: AppAlerts.info(
                      "Size bir bağlantı gönderdik. Mail kutunuzu kontrol ediniz")));
            },
            child: Text(
              "Gönder",
              style: AppText.labelSemiBold,
            ))
      ],
    );
  }

  Future passwordReset() async {
    await _auth.sendPasswordResetEmail(email: _emailController.text.trim());
  }
}
