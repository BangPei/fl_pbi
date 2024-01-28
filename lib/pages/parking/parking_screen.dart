import 'package:fl_pbi/library/library_file.dart';
import 'package:fl_pbi/pages/parking/bloc/park_bloc.dart';
import 'package:fl_pbi/pages/parking/card_summary.dart';
import 'package:fl_pbi/pages/parking/list_screen.dart';
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
          controller: _controller,
          physics: const AlwaysScrollableScrollPhysics(),
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
      ),
    );
  }
}
