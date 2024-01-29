import 'package:fl_pbi/library/library_file.dart';
import 'package:fl_pbi/pages/parking/bloc/park_bloc.dart';
import 'package:fl_pbi/pages/parking/list_screen.dart';
import 'package:fl_pbi/widget/widget_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ParkingDetailScreen extends StatefulWidget {
  final int type, year;
  final String month;
  const ParkingDetailScreen({
    super.key,
    required this.type,
    required this.year,
    required this.month,
  });

  @override
  State<ParkingDetailScreen> createState() => _ParkingDetailScreenState();
}

class _ParkingDetailScreenState extends State<ParkingDetailScreen> {
  @override
  void initState() {
    Map<String, dynamic> map = {
      "type": widget.type,
      "month": widget.month,
      "year": widget.year,
      "perpage": 50,
    };
    context.read<ParkingBloc>().add(OnGetSummary(map: map));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Detail Parkir ${widget.month} ${widget.year}",
        subTitle: Badge(
          backgroundColor:
              widget.type == 1 ? AppTheme.blue : AppTheme.nearlyDarkRed,
          textColor: AppTheme.white,
          label: Text(widget.type == 1 ? "Pemasukan" : "Pengeluaran"),
        ),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: const ListSummaryScreen(),
    );
  }
}
