import 'package:fl_pbi/library/app_theme.dart';
import 'package:fl_pbi/library/common.dart';
import 'package:flutter/material.dart';

class CardSummary extends StatefulWidget {
  const CardSummary({
    super.key,
  });

  @override
  State<CardSummary> createState() => _CardSummaryState();
}

class _CardSummaryState extends State<CardSummary> {
  bool _visible = false;
  IconData _iconData = Icons.visibility_off;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: AppTheme.white,
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 223, 223, 223),
              spreadRadius: 0.2,
              blurRadius: 7,
              offset: Offset(0, 1),
            ),
          ],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "12 Januari 2024",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 160, 160, 160),
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
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
                    icon: Icon(
                      _iconData,
                      color: AppTheme.blue,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Rp. ${_visible ? "25,000,000" : "*********"}",
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.blue,
                    ),
                  ),
                  const Text(
                    'Saldo Saat ini',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.blue,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  MoneyWidget(
                    data: "Rp. ${_visible ? "30,000,000" : "*********"}",
                    title: "Uang Masuk",
                    icon: Image.asset(
                      Common.imageEaten,
                      scale: 2.5,
                    ),
                  ),
                  MoneyWidget(
                    data: "Rp. ${_visible ? "5,000,000" : "*********"}",
                    title: "Uang Keluar",
                    icon: Image.asset(
                      Common.imageBurned,
                      scale: 2.5,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MoneyWidget extends StatelessWidget {
  const MoneyWidget({
    super.key,
    required this.title,
    required this.data,
    required this.icon,
  });

  final String title;
  final String data;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.blue,
                ),
              ),
              Text(
                data,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.blue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
