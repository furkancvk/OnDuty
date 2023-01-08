import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:on_duty/design/app_colors.dart';
import 'package:on_duty/design/app_text.dart';

class DateInput extends StatefulWidget {
  final String? label;
  static DateTime? date = DateTime.now();
  final DateTime initialDate;

  const DateInput({
    Key? key,
    this.label,
    required this.initialDate,
  }) : super(key: key);

  @override
  State<DateInput> createState() => _DateInputState();
}

class _DateInputState extends State<DateInput> {
  void callDatePicker() async {
    DateTime? date = await getDate();
    setState(() {
      DateInput.date = date ?? DateInput.date;
    });
  }

  Future<DateTime?> getDate() {
    return showDatePicker(
      context: context,
      initialDate: widget.initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
  }

  @override
  void initState() {
    super.initState();
    DateInput.date = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(widget.label != null) Text(widget.label!, style: AppText.labelSemiBold),
        if(widget.label != null) const SizedBox(height: 4),
        GestureDetector(
          onTap: callDatePicker,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.lightPrimary),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  DateFormat.yMd("tr").format(DateInput.date!),
                  style: AppText.context,
                ),
                const SizedBox(width: 10),
                const Icon(
                  FluentIcons.calendar_ltr_24_regular,
                  color: AppColors.lightPrimary,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
