import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:on_duty/design/app_colors.dart';
import 'package:on_duty/design/app_text.dart';
import 'package:on_duty/widgets/cards/alert_card.dart';
import 'package:on_duty/widgets/inputs/text_input.dart';

class ResetPasswordModal extends StatefulWidget {
  const ResetPasswordModal({Key? key}) : super(key: key);

  @override
  State<ResetPasswordModal> createState() => _ResetPasswordModalState();
}

class _ResetPasswordModalState extends State<ResetPasswordModal> {
  final _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Şifremi Değiştir"),
      titlePadding: const EdgeInsets.all(16),
      titleTextStyle: AppText.titleSemiBold,
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Şifre değiştirmek için lütfen\ne-mailinizi girin, size bir mail yollayacağız."),
            const SizedBox(height: 20),
            TextInput(
              controller: _emailController,
              label: "E-mail",
              hint: "isminiz@domain.com",
              isEmail: true,
            ),
          ],
        ),
      ),
      contentPadding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      contentTextStyle: AppText.context,
      actions: [
        OutlinedButton(
          onPressed: resetPassword,
          child: isLoading ? const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              color: AppColors.lightPrimary,
              strokeWidth: 3,
            ),
          ) : const Text("Gönder"),
        )
      ],
      actionsPadding: const EdgeInsets.all(16),
      actionsAlignment: MainAxisAlignment.end,
    );
  }

  void resetPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);
      _auth.sendPasswordResetEmail(email: _emailController.text.trim()).then((value) => {
        setState(() => isLoading = false),
        Navigator.pop(context),
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            padding: EdgeInsets.all(0),
            duration: Duration(milliseconds: 1500),
            backgroundColor: AppColors.lightSecondary,
            content: AlertCard(
              color: AppColors.lightInfo,
              message: "Size bir bağlantı gönderdik. Mail kutunuzu kontrol ediniz",
              icon: FluentIcons.info_24_regular,
            ),
          ),
        ),
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

}
