// ignore_for_file: avoid_positional_boolean_parameters

import 'package:chat_app/core/services/injection_container.dart';
import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const pink = Color(0xffFF8FB1);
  static const purple = Color(0xffBA94D1);

  static const midPink = Color(0xFFEC407A);
  static const midPurple = Color(0xff7A4495);
  static const lightPink = Color(0xffffc6d7);
  static const lightPurple = Color(0xffBA94D1);
  static const darkPink = Color(0xffde004a);
  static const darkPurple = Color(0xff18142c);

  static const white = Colors.white;
  static const black = Color(0xFF030723);
  static const success = Color(0xFF00A005);
  static const danger = Color(0xffde004a);
  static const wheat = Color(0xFFFFEBAF);
  static const transparent = Colors.transparent;

  // ---------------------------- `WIDGETS`

  static const lSplash = Color(0x95FF8FB1);
  static const dSplash = Color(0x96BA94D1);

  /// `Scaffold`
  static const lScaffoldBG = Color(0xFFFFFBF3);
  static const dScaffoldBG = Color(0xFF03071B);

  /// `ListTile`
  static const lListTile = Color(0xFFFFE2EA);
  static const dListTile = Color(0x18BA94D1);

  static Color get prim => slTheme.isDark ? purple : pink;
  static Color get mid => slTheme.isDark ? midPurple : midPink;
  static Color get light => slTheme.isDark ? lightPurple : lightPink;
  static Color get dark => slTheme.isDark ? darkPurple : darkPink;
  static Color get scaffold => slTheme.isDark ? dScaffoldBG : lScaffoldBG;
  static Color get listTile => slTheme.isDark ? dListTile : lListTile;
  static Color get normal => slTheme.isDark ? white : black;
  static const grey = Color(0xFF888888);

  // ---------------------------- `OTHER COLORS`

  // static const grey = Color(0xFFAAAAAA);
  // static const midGrey = Color(0xFF5A5A5A);
  // static const greySmoke = Color(0xDCFFFFFF);

  // static const orangePink = Color(0xffFEBEB1);
  // static const emerald = Color(0xff647E68);
  // static const wheat = Color(0xffF2DEBA);

  // static Color prim([int a = 255]) =>
  //     isDark ? AppColors.purple.withAlpha(a) : AppColors.pink.withAlpha(a);
}
