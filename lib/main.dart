import 'package:chat_app/core/constants/constants.dart';
import 'package:chat_app/core/services/injection_container.dart';
import 'package:chat_app/core/theme/app_theme.dart';
import 'package:chat_app/core/theme/cubit/theme_cubit.dart';
import 'package:chat_app/features/auth/bloc/auth_bloc.dart';
import 'package:chat_app/features/auth/models/user_model.dart';
import 'package:chat_app/features/auth/screens/sign_up_screen.dart';
import 'package:chat_app/features/chat/bloc/chat_bloc.dart';
import 'package:chat_app/features/chat/models/msg_model.dart';
import 'package:chat_app/features/chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await Hive.initFlutter();

  //  HIVE CONFIGURATIONS
  await Hive.openBox<dynamic>(BoxKeys.app); // app storage
  Hive.registerAdapter(UserModelAdapter()); // users
  await Hive.openBox<UserModel>(BoxKeys.allUsers);
  Hive.registerAdapter(MsgModelAdapter()); // messages
  await Hive.openBox<MsgModel>(BoxKeys.messages);

  await init();
  slTheme.setUp();

  // Is user authenticated?
  final isAuth = slAuth.user != null;
  runApp(MyApp(isAuth: isAuth));
}

class MyApp extends StatelessWidget {
  const MyApp({required this.isAuth, super.key});

  final bool isAuth;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<ThemeCubit>()),
        BlocProvider(create: (_) => sl<AuthBloc>()),
        BlocProvider(create: (_) => sl<ChatBloc>()),
      ],
      child: BlocBuilder<ThemeCubit, bool>(
        builder: (context, state) {
          return MaterialApp(
            title: 'ChatApp',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light(context),
            darkTheme: AppTheme.dark(context),
            themeMode: slTheme.themeMode,
            home: isAuth ? const ChatScreen() : const SignUpScreen(),
          );
        },
      ),
    );
  }
}

/*

last time - check with theme cubit
remove all unused files
proper validation for email and others - Validators class (if possible)
a very quick check on chat_tile_color_dark
app icons change to chat
display name in chat_tile

*/
