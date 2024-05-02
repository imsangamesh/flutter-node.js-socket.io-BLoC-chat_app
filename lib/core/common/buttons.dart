import 'package:chat_app/core/common/util_widgets.dart';
import 'package:chat_app/core/constants/colors.dart';
import 'package:flutter/material.dart';

/// ----------------------------------------------------- `ELEVATED`
class ElevatedBtn extends StatelessWidget {
  const ElevatedBtn(
    this.label,
    this.ontap, {
    this.icon,
    this.loading = false,
    super.key,
  });

  final VoidCallback? ontap;
  final String label;
  final IconData? icon;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: loading ? null : ontap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (loading)
            const BtnLoader()
          else if (icon != null)
            Icon(icon, size: 23),
          //
          if (icon != null || loading) const SizedBox(width: 7),
          Text(label),
        ],
      ),
    );
  }
}

/// ------------------------------------------------------ `OUTLINED`
class OutlinedBtn extends StatelessWidget {
  const OutlinedBtn(
    this.label,
    this.ontap, {
    this.icon,
    this.loading = false,
    super.key,
  });

  final VoidCallback? ontap;
  final String label;
  final IconData? icon;
  final bool loading;

  ButtonStyle get style => OutlinedButton.styleFrom(
        side: BorderSide(
          color: (loading || ontap == null) ? AppColors.grey : AppColors.prim,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: loading ? null : ontap,
      style: style,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (loading)
            const BtnLoader()
          else if (icon != null)
            Icon(icon, size: 23),
          //
          if (icon != null || loading) const SizedBox(width: 7),
          Text(label),
        ],
      ),
    );
  }
}

/// ----------------------------------------------------- `TEXT`
class TextBtn extends StatelessWidget {
  const TextBtn(
    this.label,
    this.ontap, {
    this.icon,
    this.loading = false,
    super.key,
  });

  final VoidCallback? ontap;
  final String label;
  final IconData? icon;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: loading ? null : ontap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (loading)
            const BtnLoader()
          else if (icon != null)
            Icon(icon, size: 20),
          //
          if (icon != null || loading) const SizedBox(width: 7),
          Text(label),
        ],
      ),
    );
  }
}
