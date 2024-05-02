import 'package:chat_app/core/constants/colors.dart';
import 'package:chat_app/core/constants/constants.dart';
import 'package:chat_app/core/constants/images.dart';
import 'package:flutter/material.dart';

/// `APP CUSTOM LOADER`
class Loader extends StatelessWidget {
  const Loader({this.size, super.key});

  final double? size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size ?? 17,
        width: size ?? 17,
        child: const CircularProgressIndicator(
          strokeWidth: 3.5,
          strokeCap: StrokeCap.round,
        ),
      ),
    );
  }
}

class BtnLoader extends StatelessWidget {
  const BtnLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 3),
      child: SizedBox(
        height: 16,
        width: 16,
        child: CircularProgressIndicator(
          strokeWidth: 3.5,
          strokeCap: StrokeCap.round,
          color: AppColors.scaffold,
          backgroundColor: AppColors.prim,
        ),
      ),
    );
  }
}

/// `APP CUSTOM DIVIDER`
class FullDivider extends StatelessWidget {
  const FullDivider({this.height = kDividerHt, super.key});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Divider(height: height, indent: 0, endIndent: 0);
  }
}

/// `EMPTY LIST WIDGET`
class EmptyList extends StatelessWidget {
  const EmptyList(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.bubble_chart_outlined, size: 30),
            const SizedBox(height: 5),
            Text(
              text,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({required this.value, required this.onTap, super.key});

  final bool value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: (_) => onTap(),
      activeThumbImage: const AssetImage(AppImages.darkMode),
      inactiveThumbImage: const AssetImage(AppImages.lightMode),
    );
  }
}
