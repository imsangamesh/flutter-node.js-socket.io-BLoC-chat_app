import 'package:chat_app/core/constants/colors.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField(
    this.controller,
    this.label, {
    this.maxLines = 1,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixFun,
    this.inputType,
    this.maxLength,
    this.radius,
    this.onSubmit,
    this.bottomPadding,
    this.autoFocus = false,
    this.isObscure = false,
    this.readOnly = false,
    this.validator,
    super.key,
  });

  final TextEditingController controller;
  final String label;
  final int? maxLines;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextInputType? inputType;
  final VoidCallback? suffixFun;
  final int? maxLength;
  final double? radius;
  final bool autoFocus;
  final VoidCallback? onSubmit;
  final double? bottomPadding;
  final bool isObscure;
  final bool readOnly;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding ?? 15),
      child: TextFormField(
        validator: validator,
        controller: controller,
        maxLines: maxLines,
        maxLength: maxLength,
        //
        obscureText: isObscure,
        readOnly: readOnly,
        autofocus: autoFocus,
        keyboardType: inputType ?? TextInputType.text,
        //
        style: const TextStyle(fontSize: 16),
        onTapOutside: (_) => FocusScope.of(context).unfocus(),
        cursorColor: AppColors.prim,
        // obscuringCharacter: '●',
        //
        decoration: InputDecoration(
          errorStyle: const TextStyle(fontWeight: FontWeight.w500),
          labelText: label,
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          suffixIcon: suffixIcon != null
              ? IconButton(onPressed: suffixFun, icon: Icon(suffixIcon))
              : null,
        ),
        //
        onFieldSubmitted: onSubmit == null ? null : (_) => onSubmit!(),
      ),
    );
  }
}

class Validators {
  Validators._();

  /// - - - - - - - - - - - - - - - - - - - - - `EMAIL`
  static String? email(String? value) {
    final emailRegEx = RegExp(r'^\S+@\S+\.\S+$');
    if (value == null || value.isEmpty) {
      return 'Please provide your email!';
    } else if (!emailRegEx.hasMatch(value)) {
      return 'Please provide a valid email!';
    }
    return null;
  }

  /// - - - - - - - - - - - - - - - - - - - - - `VALUE NOT EMPTY`
  static String? notEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required!';
    }
    return null;
  }
}
