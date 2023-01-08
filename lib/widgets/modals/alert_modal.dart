import 'package:flutter/material.dart';
import 'package:on_duty/design/app_text.dart';

class AlertModal extends StatelessWidget {
  const AlertModal({
    Key? key,
    required this.title,
    required this.content,
    required this.actions,
  }) : super(key: key);

  final String title;
  final String content;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title, textAlign: TextAlign.center),
      titlePadding: const EdgeInsets.all(16),
      titleTextStyle: AppText.titleSemiBold,
      content: Text(content, textAlign: TextAlign.center),
      contentPadding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      contentTextStyle: AppText.context,
      actions: actions,
      actionsPadding: const EdgeInsets.all(16),
      actionsAlignment: MainAxisAlignment.spaceBetween,
    );
  }
}
