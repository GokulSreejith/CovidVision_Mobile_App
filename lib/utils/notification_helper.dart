import 'package:covid_detective/src/covid_detective_app.dart';
import 'package:covid_detective/src/core/colors.dart';
import 'package:flutter/material.dart';

class NotificationHelper {
  static void showSnackBar({
    // required dynamic context,
    required String label,
    Duration duration = const Duration(seconds: 2),
    String disabledText = 'Close',
    Color disabledTextColor = KColors.textColor,
    Color disabledColor = Colors.blue,
    Color labelColor = KColors.textColor,
    Color backgroundColor = KColors.primaryColor,
  }) {
    ScaffoldMessenger.of(navigatorKey.currentState!.context).showSnackBar(
      SnackBar(
        duration: duration,
        behavior: SnackBarBehavior.floating,
        content: Text(
          label,
          style: TextStyle(
            color: labelColor,
          ),
        ),
        backgroundColor: backgroundColor,
        action: SnackBarAction(
          label: disabledText,
          textColor: disabledTextColor,
          disabledTextColor: disabledTextColor,
          onPressed: () {
            ScaffoldMessenger.of(navigatorKey.currentState!.context)
                .hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  static showDialogBox({
    required String title,
  }) {
    showDialog(
        context: navigatorKey.currentState!.context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(title),
          );
        });
  }
}
