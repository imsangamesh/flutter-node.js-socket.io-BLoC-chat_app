import 'package:chat_app/core/constants/colors.dart';
import 'package:chat_app/core/extensions/color_extension.dart';
import 'package:flutter/material.dart';

class AppSnackbar {
  AppSnackbar._();

  static void success(BuildContext context, String message) =>
      _showSnackbar(context, message, status: true);

  static void error(BuildContext context, String message) =>
      _showSnackbar(context, message, status: false);

  static void message(BuildContext context, String message) =>
      _showSnackbar(context, message);

  //

  static void _showSnackbar(
    BuildContext context,
    String message, {
    bool? status,
  }) {
    final bGColor = status == null
        ? AppColors.wheat
        : status
            ? AppColors.success.lighten(70)
            : AppColors.danger.lighten(70);

    final color = status == null
        ? AppColors.black
        : status
            ? AppColors.success.darken(70)
            : AppColors.danger;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: bGColor,
          content: Text(
            message,
            style: TextStyle(
              fontSize: 15.5,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ),
      );
  }
}

class AppDialog {
  const AppDialog._();

  // Have to implement other dialog boxes and generalize the logout one tooo!

  static void show(
    BuildContext context, {
    required String title,
    required String content,
    List<Widget>? actions,
  }) {
    showDialog<AlertDialog>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: actions,
        );
      },
    );
  }
}
