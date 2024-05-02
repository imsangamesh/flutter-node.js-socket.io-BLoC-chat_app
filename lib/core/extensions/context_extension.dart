import 'package:chat_app/core/theme/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension ContextExt on BuildContext {
  MediaQueryData get media => MediaQuery.of(this);

  Size get size => media.size;
  double get h => size.height;
  double get w => size.width;

  ThemeCubit get theme => read<ThemeCubit>();
}
