import 'dart:developer';

import 'package:chat_app/core/theme/cubit/theme_cubit.dart';
import 'package:chat_app/features/auth/bloc/auth_bloc.dart';
import 'package:chat_app/features/auth/repos/auth_repo.dart';
import 'package:chat_app/features/chat/bloc/chat_bloc.dart';
import 'package:chat_app/features/chat/repos/chat_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

final sl = GetIt.instance;

final slUuid = sl<Uuid>();

final slTheme = sl<ThemeCubit>();
final slAuth = sl<AuthBloc>();

Future<void> init() async {
  // External Dependencies
  sl
    ..registerLazySingleton(() => Hive) // Hive
    ..registerLazySingleton(Uuid.new); // Uuid

  await _initTheme();
  await _initAuth();
  await _initChat();
}

Future<void> _initTheme() async {
  sl.registerFactory(() => ThemeCubit(hive: sl()));
  log(' - - - - - - THEME dependency injected! - - - - - - ');
}

Future<void> _initAuth() async {
  sl
    ..registerFactory(() => AuthBloc(authRepo: sl()))
    ..registerLazySingleton(() => AuthRepo(hive: sl()));

  log(' - - - - - - AUTH dependencies injected! - - - - - - ');
}

Future<void> _initChat() async {
  sl
    ..registerFactory(() => ChatBloc(chatRepo: sl()))
    ..registerLazySingleton(() => ChatRepo(hive: sl()));

  log(' - - - - - - CHAT dependencies injected! - - - - - - ');
}
