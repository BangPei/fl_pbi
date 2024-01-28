import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color? textColor;
  final Color? backgroundColor;
  final VoidCallback? onPressed;
  final Widget? icon;
  final EdgeInsetsGeometry? padding;
  final Widget? title;

  const CustomButton({
    super.key,
    this.textColor,
    this.backgroundColor,
    this.onPressed,
    this.icon,
    this.title,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: textColor ?? Colors.white,
          backgroundColor: backgroundColor ?? Colors.blueAccent,
        ),
        onPressed: onPressed ?? () {},
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: icon == null ? false : true,
                child: icon ?? const SizedBox.shrink(),
              ),
              const SizedBox(width: 5),
              title ??
                  const Text(
                    "title",
                    style: TextStyle(fontSize: 18),
                  )
            ],
          ),
        ),
      ),
    );
  }
}
