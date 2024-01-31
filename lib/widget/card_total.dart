import 'package:fl_pbi/library/library_file.dart';
import 'package:flutter/material.dart';

class CardTotal extends StatefulWidget {
  final dynamic data;
  const CardTotal({super.key, this.data = 0});

  @override
  State<CardTotal> createState() => _CardTotalState();
}

class _CardTotalState extends State<CardTotal> {
  bool _visible = false;
  // ignore: unused_field
  IconData _iconData = Icons.visibility_off;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        height: 90,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.white,
          gradient: AppTheme.gradient,
          boxShadow: const [AppTheme.boxShadow],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Saldo Saat ini',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.white,
                    ),
                  ),
                  Text(
                    "Rp. ${Common.oCcy.format(widget.data)}",
                    // "Rp. ${_visible ? Common.oCcy.format(widget.data) : "*********"}",
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.white,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _visible = !_visible;
                  _iconData =
                      _visible ? Icons.visibility : Icons.visibility_off;
                });
              },
              icon: const Icon(
                Icons.visibility,
                // _iconData,
                color: AppTheme.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
