import 'package:fl_pbi/library/app_theme.dart';
import 'package:flutter/material.dart';

class FormTitle extends StatelessWidget {
  final String title;
  const FormTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 5.0,
        bottom: 10,
        top: 10,
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 18,
          color: AppTheme.nearlyBlack,
        ),
      ),
    );
  }
}
