import 'package:fl_pbi/pages/parking/bloc/park_bloc.dart';
import 'package:fl_pbi/pages/parking/card_summary.dart';
import 'package:fl_pbi/pages/parking/list_screen.dart';
import 'package:fl_pbi/widget.dart/custom_appbar.dart';
import 'package:fl_pbi/widget.dart/form_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ParkingScreen extends StatefulWidget {
  const ParkingScreen({super.key});

  @override
  State<ParkingScreen> createState() => _ParkingScreenState();
}

class _ParkingScreenState extends State<ParkingScreen> {
  final ScrollController _controller = ScrollController();
  @override
  void initState() {
    _controller.addListener(() {
      if (_controller.position.maxScrollExtent == _controller.offset) {
        context.read<ParkingBloc>().add(OnLoadMore());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const CustomAppbar(title: "Summary Uang Parkir"),
      body: SingleChildScrollView(
        controller: _controller,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CardSummary(),
              const FormTitle(
                title: "Histori Uang Masuk dan Keluar",
                padding: EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 20,
                ),
              ),
              const ListSummaryScreen(),
              BlocBuilder<ParkingBloc, ParkingState>(
                builder: (context, state) {
                  if (state.loadMore) {
                    return const SizedBox(
                      height: 70,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
