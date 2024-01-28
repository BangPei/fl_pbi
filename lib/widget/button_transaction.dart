import 'package:fl_pbi/library/library_file.dart';
import 'package:flutter/material.dart';

class ButtonTransaction extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  const ButtonTransaction({
    super.key,
    required this.title,
    this.onTap,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                color: AppTheme.white,
                fontWeight: FontWeight.w700,
                fontSize: 20,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
