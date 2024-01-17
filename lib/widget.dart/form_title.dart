import 'package:fl_pbi/library/app_theme.dart';
import 'package:flutter/material.dart';

class FormTitle extends StatelessWidget {
  final String title;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;
  const FormTitle(
      {super.key, required this.title, this.padding, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ??
          const EdgeInsets.only(
            left: 5.0,
            bottom: 10,
            top: 10,
          ),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: fontSize ?? 18,
          color: AppTheme.nearlyBlack,
        ),
      ),
    );
  }
}
