import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomSnackBar {
  static void show(BuildContext context, String message, SnackBarType type, {VoidCallback? onRetry}) {
    Color backgroundColor;
    IconData icon;
    String actionLabel = "";
    VoidCallback? onActionPressed;

    switch (type) {
      case SnackBarType.error:
        backgroundColor = Colors.red;
        icon = Icons.error;
        actionLabel = "actions.retry".tr();
        onActionPressed = onRetry;
        break;
      case SnackBarType.success:
        backgroundColor = Colors.green;
        icon = Icons.check_circle;
        break;
      case SnackBarType.warning:
        backgroundColor = Colors.orange;
        icon = Icons.warning;
        break;
      default:
        backgroundColor = Colors.blue;
        icon = Icons.info;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        duration: Duration(seconds: 1),
        action: onActionPressed != null
            ? SnackBarAction(
                label: actionLabel,
                textColor: Colors.yellow,
                onPressed: onActionPressed,
              )
            : null,
      ),
    );
  }
}

enum SnackBarType {
  success,
  error,
  warning,
  info,
}
