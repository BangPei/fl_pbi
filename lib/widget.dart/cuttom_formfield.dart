import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';

class CustomFormField extends ResponsiveGridCol {
  final String title;
  final Widget textForm;
  CustomFormField({
    super.key,
    required this.title,
    required this.textForm,
    super.child = const SizedBox.shrink(),
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveGridCol(
      lg: 4,
      xl: 4,
      md: 4,
      sm: 12,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 5.0,
          vertical: 5,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 3),
            textForm,
          ],
        ),
      ),
    );
  }
}
