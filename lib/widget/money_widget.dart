import 'package:fl_pbi/library/library_file.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MoneyWidget extends StatelessWidget {
  const MoneyWidget({
    super.key,
    required this.title,
    required this.data,
    required this.icon,
    this.onTap,
  });

  final String title;
  final String data;
  final Widget icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 3),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.white,
                  ),
                ),
                Text(
                  data,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.white,
                  ),
                ),
              ],
            ),
            const FaIcon(
              Icons.arrow_right,
              color: AppTheme.white,
              size: 30,
            )
          ],
        ),
      ),
    );
  }
}
