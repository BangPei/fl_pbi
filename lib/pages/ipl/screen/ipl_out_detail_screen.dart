import 'package:fl_pbi/library/library_file.dart';
import 'package:fl_pbi/models/models.dart';
import 'package:fl_pbi/pages/ipl/bloc/ipl_bloc.dart';
import 'package:fl_pbi/pages/report/bloc/report_bloc.dart';
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
  final ScrollController _controller = ScrollController();
  @override
  void initState() {
    map = {
      "type": widget.type,
      "month": widget.month,
      "year": widget.year,
      "perpage": 100,
    };
    context.read<IplBloc>().add(OnGetOutDetail(map));
    _controller.addListener(() {
      if (_controller.position.maxScrollExtent == _controller.offset) {
        context.read<IplBloc>().add(OnLoadMore());
      }
    });
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
        actions: IconButton(
          onPressed: () {
            Map<String, dynamic> map = {
              "month": widget.month.toLowerCase(),
              "year": widget.year,
            };
            context.read<ReportBloc>().add(OnChangedPeriode(map));
            context.goNamed(
              'report-ipl',
              extra: {
                'reportType': "ipl",
                "type": widget.type,
                "month": widget.month,
                "year": widget.year,
              },
            );
          },
          icon: const Icon(
            Icons.print,
            color: AppTheme.grey,
          ),
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
          return RefreshIndicator(
            onRefresh: () async {
              context.read<IplBloc>().add(OnGetOutDetail(map));
            },
            child: SingleChildScrollView(
              controller: _controller,
              physics: const AlwaysScrollableScrollPhysics(),
              child: ListSummaryScreen<Transaction>(
                list: state.ipls ?? [],
                onTap: (id) {
                  context.goNamed("ipl-form-detail-out", extra: {
                    "type": 2,
                    'month': widget.month,
                    'year': widget.year,
                    "id": id
                  });
                },
                onConfirm: (id) {
                  context.read<IplBloc>().add(OnRemoveIPL(id, map));
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
