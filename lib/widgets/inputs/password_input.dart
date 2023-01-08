import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:on_duty/design/app_text.dart';
import 'package:on_duty/widgets/inputs/text_input.dart';
import 'package:on_duty/widgets/modals/reset_password_modal.dart';

class PasswordInput extends StatefulWidget {
  final String? hint;
  final TextEditingController controller;
  final bool isForgotPassword;

  const PasswordInput({
    Key? key,
    this.hint,
    required this.controller,
    this.isForgotPassword = true,
  }) : super(key: key);

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextInput(
          controller: widget.controller,
          label: "Şifre",
          hint: widget.hint,
          isObscure: isObscure,
          isPassword: true,
          suffixIcon: IconButton(
            onPressed: changePasswordVisibility,
            splashRadius: 20,
            icon: Icon(!isObscure
              ? FluentIcons.eye_24_regular
              : FluentIcons.eye_off_24_regular,
            ),
          ),
        ),
        if(widget.isForgotPassword) Positioned(
          right: -16,
          top: -14,
          child: TextButton(
            onPressed: forgotPassword,
            child: Text("Şifremi Unuttum", style: AppText.label),
          ),
        ),
      ],
    );
  }

  void changePasswordVisibility() {
    setState(() {
      isObscure = !isObscure;
    });
  }

  void forgotPassword(){
    showDialog(
      context: context,
      builder: (BuildContext context) => const ResetPasswordModal(),
    );
  }
}
