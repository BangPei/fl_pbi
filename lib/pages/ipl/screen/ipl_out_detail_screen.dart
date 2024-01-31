import 'package:fl_pbi/library/library_file.dart';
import 'package:fl_pbi/pages/ipl/bloc/ipl_bloc.dart';
import 'package:fl_pbi/pages/ipl/data/ipl.dart';
import 'package:fl_pbi/widget/widget_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class IPLOutDetailScreen extends StatefulWidget {
  final String month;
  final int year;
  final int type;
  const IPLOutDetailScreen({
    super.key,
    required this.month,
    required this.year,
    required this.type,
  });

  @override
  State<IPLOutDetailScreen> createState() => _IPLOutDetailScreenState();
}

class _IPLOutDetailScreenState extends State<IPLOutDetailScreen> {
  Map<String, dynamic> map = {};
  @override
  void initState() {
    map = {
      "type": widget.type,
      "month": widget.month,
      "year": widget.year,
      "perpage": 100,
    };
    context.read<IplBloc>().add(OnGetOutDetail(map));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Detail IPL ${widget.month} ${widget.year}",
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
      body: BlocBuilder<IplBloc, IplState>(
        builder: (context, state) {
          if (state.listLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.isError) {
            return Center(child: Text(state.errorMessage ?? "Error"));
          }
          return ListSummaryScreen<IPL>(
            list: state.ipls ?? [],
            onTap: (id) {},
            onConfirm: (id) {
              context.read<IplBloc>().add(OnRemoveIPL(id, map));
            },
          );
        },
      ),
    );
  }
}
