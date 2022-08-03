import 'package:flutter/material.dart';
import 'package:todo/app/theme/app_colors.dart';
import 'package:todo/app/theme/styles.dart';

class PrimaryFilledButton extends StatelessWidget {
  final String? text;
  final Widget? child;
  final VoidCallback? onTap;
  final Color? color;

  PrimaryFilledButton(
      {this.text,
      required this.onTap,
      this.child,
      this.color = AppColors.secondaryColor});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      color: color,
      child: Container(
        width: double.infinity,
        height: 50,
        child: Center(
          child: child ??
              Text(
                text ?? "",
                style: Styles.tsWhiteLight12,
              ),
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0)),
    );
  }
}
