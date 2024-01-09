import 'package:fl_pbi/pages/parking/card_summary.dart';
import 'package:fl_pbi/pages/parking/list_screen.dart';
import 'package:fl_pbi/widget.dart/custom_appbar.dart';
import 'package:fl_pbi/widget.dart/form_title.dart';
import 'package:flutter/material.dart';

class ParkingScreen extends StatefulWidget {
  const ParkingScreen({super.key});

  @override
  State<ParkingScreen> createState() => _ParkingScreenState();
}

class _ParkingScreenState extends State<ParkingScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
      appBar: CustomAppbar(title: "Summary Uang Parkir"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CardSummary(),
            FormTitle(
              title: "Histori Uang Masuk dan Keluar",
              padding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 20,
              ),
            ),
            ListSummaryScreen(),
          ],
        ),
      ),
    );
  }
}
