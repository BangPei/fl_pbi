import 'package:fl_pbi/library/library_file.dart';
import 'package:fl_pbi/pages/ipl/bloc/ipl_bloc.dart';
import 'package:fl_pbi/widget/widget_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class IPLScreen extends StatefulWidget {
  const IPLScreen({super.key});

  @override
  State<IPLScreen> createState() => _ParkingScreenState();
}

class _ParkingScreenState extends State<IPLScreen> {
  String year = "2024";
  String type = "1";
  @override
  void initState() {
    context.read<IplBloc>().add(OnGetTotal());
    context.read<IplBloc>().add(OnGetTrans(year, type));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Summary Uang IPL",
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
                context.goNamed("ipl-form", extra: {"type": 1});
              },
              onTapOut: () {
                context.goNamed("ipl-form", extra: {"type": 2});
              },
            );
          },
          icon: const FaIcon(FontAwesomeIcons.plus),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<IplBloc>().add(OnGetTotal());
          context.read<IplBloc>().add(OnGetTrans(year, type));
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<IplBloc, IplState>(
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
                  title: "Total IPL PerBulan Tahun",
                  type: type,
                  year: year,
                  onTapDate: (yr) {
                    year = yr;
                    context.read<IplBloc>().add(OnGetTrans(yr, type));
                    setState(() {});
                  },
                ),
                ButtonInOut(
                  onTap: (idx) {
                    type = idx >= 1 ? "2" : "1";
                    setState(() {});
                    context.read<IplBloc>().add(OnGetTrans(year, type));
                  },
                ),
                BlocBuilder<IplBloc, IplState>(
                  builder: (context, state) {
                    if (state.listLoading) {
                      return const LoadingScreen();
                    }
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: ListTransaction(
                        trans: state.trans ?? [],
                        type: int.parse(type),
                        onTap: (tran) {
                          context.goNamed(
                            'ipl-detail',
                            extra: {
                              "type": int.parse(type),
                              "month": tran.month,
                              "year": tran.year
                            },
                          );
                        },
                      ),
                    );
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
