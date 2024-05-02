import 'package:chat_app/core/constants/colors.dart';
import 'package:flutter/material.dart';

class AppTStyles {
  AppTStyles._();

  // ------------------------------------------------------

  static TextStyle caption = const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.grey,
  );

  static TextStyle get midCaption => TextStyle(
        fontSize: 15.5,
        fontWeight: FontWeight.w500,
        color: AppColors.mid,
      );

  static TextStyle get body => TextStyle(
        fontSize: 16,
        color: AppColors.normal,
      );

  static TextStyle get primary => TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: AppColors.prim,
      );

  static TextStyle get subHeading => const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get heading => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.normal,
      );

  static TextStyle get large => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.normal,
      );
}

/*
// 1 playfairDisplay
// 1 berkshireSwash
// 2 quicksand
// 3 zillaSlab - M

// amaticSc
*/
