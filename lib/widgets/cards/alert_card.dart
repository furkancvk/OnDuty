import 'package:flutter/material.dart';

class AlertCard extends StatelessWidget {
  final IconData icon;
  final String message;
  final Color color;

  const AlertCard({
    Key? key,
    required this.color,
    required this.message,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: (color).withOpacity(0.16),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 2, child: Icon(icon, color: color, size: 28)),
          const SizedBox(width: 10),
          Expanded(
            flex: 20,
            child: Text(
              message,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.4,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
