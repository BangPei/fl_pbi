import 'package:fl_pbi/library/library_file.dart';
import 'package:fl_pbi/pages/parking/bloc/park_bloc.dart';
import 'package:fl_pbi/widget/widget_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class ParkingScreen extends StatefulWidget {
  const ParkingScreen({super.key});

  @override
  State<ParkingScreen> createState() => _ParkingScreenState();
}

class _ParkingScreenState extends State<ParkingScreen> {
  String year = "2024";
  String type = "1";
  @override
  void initState() {
    context.read<ParkingBloc>().add(OnGetTotal());
    context.read<ParkingBloc>().add(OnGetTrans(year, type));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Summary Uang Parkir",
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        actions: IconButton(
          visualDensity: const VisualDensity(vertical: -4),
          onPressed: () {
            Common.dialogInOutCome(
              context,
              onTapIn: () {
                context.goNamed("keuangan-form", extra: {"type": 1});
              },
              onTapOut: () {
                context.goNamed("keuangan-form", extra: {"type": 2});
              },
            );
          },
          icon: const FaIcon(FontAwesomeIcons.plus),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<ParkingBloc>().add(OnGetSummary());
          context.read<ParkingBloc>().add(OnGetTotal());
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<ParkingBloc, ParkingState>(
                  builder: (context, state) {
                    if (state.cardLoaing) {
                      return const LoadingScreen();
                    }
                    return CardTotal(
                      data: state.cashFlow?.rest,
                    );
                  },
                ),
                TitleList(
                  title: "Total Parkir PerBulan Tahun",
                  type: type,
                  year: year,
                  onTapDate: () {},
                ),
                ButtonInOut(
                  onTap: (idx) {
                    type = idx >= 1 ? "2" : "1";
                    setState(() {});
                  },
                ),
                BlocBuilder<ParkingBloc, ParkingState>(
                  builder: (context, state) {
                    if (state.listLoading) {
                      return const LoadingScreen();
                    }
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: ListTransaction(
                        trans: state.trans ?? [],
                        type: int.parse(type),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
