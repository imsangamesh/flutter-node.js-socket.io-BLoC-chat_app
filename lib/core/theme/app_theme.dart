// ignore_for_file: avoid_positional_boolean_parameters

import 'package:chat_app/core/constants/app_text_styles.dart';
import 'package:chat_app/core/constants/colors.dart';
import 'package:chat_app/core/constants/constants.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // ============================== LIGHT ==============================
  // ============================== LIGHT ==============================

  static ThemeData light(BuildContext c) {
    return ThemeData.light().copyWith(
      /// -------------------------------------- `CORE`
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.pink),
      splashColor: AppColors.lSplash,
      scaffoldBackgroundColor: AppColors.lScaffoldBG,
      textTheme: Theme.of(c).textTheme.apply(bodyColor: AppColors.black),

      /// -------------------------------------- `CORE WIDGETS`
      appBarTheme: appBarTheme(c),
      floatingActionButtonTheme: floatingActionButton(c),
      drawerTheme: drawer(c),

      /// -------------------------------------- `BUTTONS`
      elevatedButtonTheme: elevatedButton(),
      outlinedButtonTheme: outlinedButton(),
      textButtonTheme: textButton(),
      toggleButtonsTheme: toggleButton(c),

      /// -------------------------------------- `LISTTILES`
      listTileTheme: listTile(c),

      /// -------------------------------------- `TEXTFIELD`
      inputDecorationTheme: inputDecorationTheme(c),

      /// -------------------------------------- `OTHERS`
      iconTheme: iconTheme(),
      dividerTheme: dividerTheme(),
      progressIndicatorTheme: progressIndicator(),
      switchTheme: switchTheme(),
      dialogTheme: dialogTheme(),
    );
  }

  // ============================== DARK ==============================
  // ============================== DARK ==============================

  static ThemeData dark(BuildContext c) {
    return ThemeData.dark().copyWith(
      /// -------------------------------------- `CORE`
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.purple),
      splashColor: AppColors.dSplash,
      scaffoldBackgroundColor: AppColors.dScaffoldBG,
      textTheme: Theme.of(c).textTheme.apply(bodyColor: AppColors.white),

      /// -------------------------------------- `CORE WIDGETS`
      appBarTheme: appBarTheme(c, true),
      floatingActionButtonTheme: floatingActionButton(c, true),
      drawerTheme: drawer(c, true),

      /// -------------------------------------- `BUTTONS`
      elevatedButtonTheme: elevatedButton(true),
      outlinedButtonTheme: outlinedButton(true),
      textButtonTheme: textButton(true),
      toggleButtonsTheme: toggleButton(c, true),

      /// -------------------------------------- `LISTTILES`
      listTileTheme: listTile(c, true),

      /// -------------------------------------- `TEXTFIELD`
      inputDecorationTheme: inputDecorationTheme(c, true),

      /// -------------------------------------- `OTHERS`
      iconTheme: iconTheme(true),
      dividerTheme: dividerTheme(true),
      progressIndicatorTheme: progressIndicator(true),
      dialogTheme: dialogTheme(),
    );
  }

  /// ---------------------------------------------------------- `COLORS`

  static Color normalColor(bool isDark) =>
      isDark ? AppColors.white : AppColors.black;

  /// ---------------------------------------------------------- `CORE WIDGETS`

  static AppBarTheme appBarTheme(BuildContext c, [bool isDark = false]) {
    return Theme.of(c).appBarTheme.copyWith(
          iconTheme: IconThemeData(color: AppColors.prim, size: 24),
          titleTextStyle: TextStyle(
            color: AppColors.prim,
            fontSize: 19,
            fontWeight: FontWeight.w500,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        );
  }

  static DrawerThemeData drawer(BuildContext c, [bool isDark = false]) {
    return Theme.of(c).drawerTheme.copyWith(
          backgroundColor: AppColors.scaffold,
        );
  }

  static FloatingActionButtonThemeData floatingActionButton(
    BuildContext c, [
    bool isDark = false,
  ]) {
    return Theme.of(c).floatingActionButtonTheme.copyWith(
          backgroundColor: isDark ? AppColors.purple : AppColors.pink,
          iconSize: 30,
        );
  }

  /// ---------------------------------------------------------- `BUTTONS`

  static ElevatedButtonThemeData elevatedButton([bool isDark = false]) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: kButtonPad),
        foregroundColor: AppColors.scaffold,
        backgroundColor: AppColors.prim,
        disabledForegroundColor: AppColors.prim,
        disabledBackgroundColor: AppColors.prim.withAlpha(100),
        textStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kBR),
        ),
      ),
    );
  }

  static OutlinedButtonThemeData outlinedButton([bool isDark = false]) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: kButtonPad),
        foregroundColor: AppColors.prim,
        disabledForegroundColor: AppColors.grey,
        textStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kBR),
        ),
        side: BorderSide(color: AppColors.prim),
      ),
    );
  }

  static TextButtonThemeData textButton([bool isDark = false]) {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        foregroundColor: AppColors.prim,
        disabledForegroundColor: AppColors.prim.withAlpha(150),
        textStyle: AppTStyles.caption,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kBR),
        ),
      ),
    );
  }

  static ToggleButtonsThemeData toggleButton(
    BuildContext c, [
    bool isDark = false,
  ]) {
    return Theme.of(c).toggleButtonsTheme.copyWith(
          selectedColor: AppColors.prim,
          color: normalColor(isDark),
          borderColor: AppColors.prim.withAlpha(100),
          selectedBorderColor: AppColors.prim,
          borderRadius: BorderRadius.circular(kBR),
          textStyle: AppTStyles.primary,
        );
  }

  /// ---------------------------------------------------------- `LIST TILES`

  static ListTileThemeData listTile(BuildContext c, [bool isDark = false]) {
    return Theme.of(c).listTileTheme.copyWith(
          tileColor: AppColors.listTile,
          contentPadding: const EdgeInsets.fromLTRB(17, 1, 5, 1),
          titleTextStyle: AppTStyles.body,
          iconColor: AppColors.prim,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kBR),
          ),
        );
  }

  /// ---------------------------------------------------------- `TEXTFIELD`
  ///

  static InputDecorationTheme inputDecorationTheme(
    BuildContext c, [
    bool isDark = false,
  ]) {
    return Theme.of(c).inputDecorationTheme.copyWith(
          labelStyle: TextStyle(color: AppColors.prim, fontSize: 15),
          counterStyle: TextStyle(color: AppColors.mid),
          suffixIconColor: AppColors.prim,
          prefixIconColor: AppColors.prim,
          filled: true,
          fillColor: AppColors.listTile,
          contentPadding: const EdgeInsets.all(18),
          alignLabelWithHint: true,
          //
          enabledBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: AppColors.transparent, width: 0),
            borderRadius: BorderRadius.circular(kBR),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.prim, width: 2),
            borderRadius: BorderRadius.circular(kBR),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.danger, width: 2),
            borderRadius: BorderRadius.circular(kBR),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.danger, width: 2),
            borderRadius: BorderRadius.circular(kBR),
          ),
        );
  }

  /// ---------------------------------------------------------- `OTHERS`

  static IconThemeData iconTheme([bool isDark = false]) {
    return const IconThemeData().copyWith(
      color: AppColors.prim,
      size: 28,
    );
  }

  static DividerThemeData dividerTheme([bool isDark = false]) {
    return const DividerThemeData().copyWith(
      color: AppColors.prim.withAlpha(50),
      space: kDividerHt,
      indent: 10,
      endIndent: 10,
    );
  }

  static ProgressIndicatorThemeData progressIndicator([bool isDark = false]) {
    return ProgressIndicatorThemeData(
      color: AppColors.prim,
      circularTrackColor: AppColors.scaffold,
    );
  }

  static SwitchThemeData switchTheme() {
    return SwitchThemeData(
      trackOutlineColor: MaterialStateProperty.resolveWith(
        (states) => AppColors.prim,
      ),
    );
  }

  static DialogTheme dialogTheme() {
    return DialogTheme(
      titleTextStyle: AppTStyles.heading,
      contentTextStyle: AppTStyles.body,
    );
  }
}
