import 'package:fl_pbi/library/library_file.dart';
import 'package:fl_pbi/models/models.dart';
import 'package:fl_pbi/pages/parking/bloc/park_bloc.dart';
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
  Map<String, dynamic> map = {};
  final ScrollController _controller = ScrollController();
  @override
  void initState() {
    map = {
      "type": widget.type,
      "month": widget.month,
      "year": widget.year,
      "perpage": 50,
    };
    context.read<ParkingBloc>().add(OnGetSummary(map: map));
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
      body: BlocBuilder<ParkingBloc, ParkingState>(
        builder: (context, state) {
          if (state.listLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.isError) {
            return Center(child: Text(state.errorMessage ?? "Error"));
          }
          return RefreshIndicator(
            onRefresh: () async {
              context.read<ParkingBloc>().add(OnGetSummary(map: map));
            },
            child: SingleChildScrollView(
              controller: _controller,
              physics: const AlwaysScrollableScrollPhysics(),
              child: ListSummaryScreen<Transaction>(
                list: state.parks ?? [],
                onTap: (id) => context.goNamed("parking-form-detail", extra: {
                  "type": widget.type,
                  "id": id,
                  "month": widget.month,
                  "year": widget.year
                }),
                onConfirm: (id) {
                  context.read<ParkingBloc>().add(OnRemovePark(id));
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
