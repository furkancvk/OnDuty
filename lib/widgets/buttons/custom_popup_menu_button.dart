import 'package:flutter/material.dart';
import 'package:on_duty/design/app_colors.dart';
import 'package:on_duty/design/app_text.dart';

class CustomPopupMenuButton extends StatelessWidget {
  const CustomPopupMenuButton({
    Key? key,
    required this.data,
    required this.child,
  }) : super(key: key);

  final List<Map<String, dynamic>> data;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (int index) => data[index]["onPress"](),
      itemBuilder: (context) => List.generate(data.length, (index) {
        return PopupMenuItem(
          value: index,
          child: Row(
            children: [
              Icon(data[index]["icon"], color: AppColors.lightPrimary),
              const SizedBox(width: 10),
              Text(data[index]["title"], style: AppText.contextSemiBold),
            ],
          ),
        );
      }),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
        side: const BorderSide(color: AppColors.lightPrimary),
      ),
      color: AppColors.lightSecondary,
      offset: const Offset(-24, 16),
      elevation: 0,
      child: child,
    );
  }
}
