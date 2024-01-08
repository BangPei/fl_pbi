import 'package:fl_pbi/library/app_theme.dart';
import 'package:flutter/material.dart';

class CardBanner extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final Widget? leading;
  final GestureTapCallback? onTap;
  const CardBanner({
    Key? key,
    required this.title,
    this.trailing,
    this.leading,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(3),
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        decoration: BoxDecoration(
          gradient: AppTheme.gradient,
          boxShadow: const [AppTheme.boxShadow],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                leading ?? const SizedBox.shrink(),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 19,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            trailing ?? const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
