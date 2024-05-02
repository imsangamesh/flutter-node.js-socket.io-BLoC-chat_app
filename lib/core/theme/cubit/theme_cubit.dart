import 'dart:developer';

import 'package:chat_app/core/constants/constants.dart';
import 'package:chat_app/core/services/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class ThemeCubit extends Cubit<bool> {
  ThemeCubit({required HiveInterface hive})
      : _hive = hive,
        super(false);

  final HiveInterface _hive;

  Box<dynamic> get appBox => _hive.box<dynamic>(BoxKeys.app);

  bool get isDark {
    if (appBox.isEmpty) return false;
    return appBox.get(BoxKeys.isDark) as bool? ?? false;
  }

  ThemeMode get themeMode => isDark ? ThemeMode.dark : ThemeMode.light;

  void setUp() {
    emit(isDark);
    log(' - - - - THEME setup complete | isDark: $state - - - - ');
  }

  void toggleTheme() {
    final newState = !slTheme.isDark;
    emit(newState);
    appBox.put(BoxKeys.isDark, newState);
  }
}
