import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String title;
  final Widget textForm;
  const CustomFormField({
    super.key,
    required this.title,
    required this.textForm,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
