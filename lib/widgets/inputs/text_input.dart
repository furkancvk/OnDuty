import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:on_duty/design/app_text.dart';
import 'package:on_duty/utils/form_validation.dart';

class TextInput extends StatelessWidget {
  final String? label;
  final String? hint;
  final TextEditingController controller;
  final RegExp? formatter;
  final int maxLines;
  final bool isEmail;
  final bool isPassword;
  final bool isObscure;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;

  const TextInput({
    Key? key,
    this.label,
    this.hint,
    required this.controller,
    this.formatter,
    this.maxLines = 1,
    this.isEmail = false,
    this.isPassword = false,
    this.isObscure = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(label != null) Text(label!, style: AppText.labelSemiBold),
        if(label != null) const SizedBox(height: 4),
        TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "${label?.toLowerCase()} alanı boş bırakılamaz.";
            } else if (isEmail) {
              return FormValidation.validateEmail(value);
            } else if (isPassword) {
              return FormValidation.validatePassword(value);
            } else {
              return null;
            }
          },
          onChanged: onChanged,
          controller: controller,
          obscureText: isObscure,
          maxLines: maxLines,
          inputFormatters: formatter != null ? [FilteringTextInputFormatter.allow(formatter!)] : null,
          keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}
