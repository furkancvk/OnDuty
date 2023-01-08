import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../design/app_colors.dart';

class AppAlerts {
  static Future<bool?> toast({
    required String message,
    Color backgroundColor = AppColors.lightPrimary,
    Color textColor = AppColors.lightSecondary,
  }) {
    return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor.withOpacity(.7),
      textColor: textColor,
      fontSize: 16,
    );
  }
}
