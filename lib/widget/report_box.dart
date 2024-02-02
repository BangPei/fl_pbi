import 'package:fl_pbi/library/library_file.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReportBox extends StatelessWidget {
  final String label;
  final Widget? icon;
  final GestureTapCallback? onTap;
  const ReportBox({super.key, required this.label, this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppTheme.white.withOpacity(0.9),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 190, 189, 189),
              spreadRadius: 0.2,
              blurRadius: 2,
              offset: Offset(0, 1),
            )
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon ??
                Icon(
                  FontAwesomeIcons.car,
                  size: 35,
                  color: AppTheme.nearlyDarkRed.withOpacity(0.7),
                ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: AppTheme.lightText,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
