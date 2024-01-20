import 'package:fl_pbi/library/app_theme.dart';
import 'package:flutter/material.dart';

class EmptyCard extends StatelessWidget {
  const EmptyCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 216, 216, 216),
              spreadRadius: 0.2,
              blurRadius: 2,
              offset: Offset(0, 1),
            )
          ],
        ),
        child: const Center(
          child: Text(
            "Tidak Ada Data",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
