import 'package:flutter/material.dart';
import 'package:on_duty/design/app_colors.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.lightPrimary.withOpacity(0.04),
        borderRadius: BorderRadius.circular(4),
      ),
      constraints: const BoxConstraints(maxWidth: 120),
      child: Row(
        children: [
          Icon(icon, color: AppColors.lightBlack, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.4,
                color: AppColors.lightBlack,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
