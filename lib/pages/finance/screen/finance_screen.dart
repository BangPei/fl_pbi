import 'package:fl_pbi/library/library_file.dart';
import 'package:fl_pbi/pages/finance/bloc/finanace_bloc.dart';
import 'package:fl_pbi/pages/finance/data/finance.dart';
import 'package:fl_pbi/pages/finance/screen/finance_total_card.dart';
import 'package:fl_pbi/widget/widget_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FinanceScreen extends StatefulWidget {
  const FinanceScreen({super.key});

  @override
  State<FinanceScreen> createState() => _FinanceScreenState();
}

class _FinanceScreenState extends State<FinanceScreen> {
  @override
  void initState() {
    context.read<FinanceBloc>().add(OnGetTotal());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const CustomAppbar(
        title: "Keuangan",
      ),
      body: RefreshIndicator(
        onRefresh: () async => context.read<FinanceBloc>().add(OnGetTotal()),
        child: BlocListener<FinanceBloc, FinanceState>(
          listener: (context, state) {
            if (state.isError) {
              Common.modalInfo(
                context,
                title: "Gagal",
                message: state.errorMessage,
                mode: MODE.error,
              );
            }
          },
          child: BlocBuilder<FinanceBloc, FinanceState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const LoadingScreen();
              }
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FinanceTotalCard(data: state.finance ?? Finance()),
                      // const FormTitle(
                      //   title: "Transaksi Terakhir Parkir",
                      //   fontSize: 14,
                      //   padding: EdgeInsets.only(
                      //     top: 20,
                      //     left: 20,
                      //     right: 20,
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.all(16.0),
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       color: AppTheme.white,
                      //       borderRadius: BorderRadius.circular(8),
                      //       boxShadow: const [
                      //         BoxShadow(
                      //           color: Color.fromARGB(255, 189, 188, 188),
                      //           spreadRadius: 0.2,
                      //           blurRadius: 2,
                      //           offset: Offset(0, 1),
                      //         )
                      //       ],
                      //     ),
                      //     child: const Column(
                      //       children: [
                      //         ListTile(
                      //           minVerticalPadding: 0,
                      //           title: Text("Rp. 270,000"),
                      //           subtitle: Text("1 Januari 2024"),
                      //         ),
                      //         Padding(
                      //           padding: EdgeInsets.symmetric(horizontal: 8.0),
                      //           child: Divider(),
                      //         ),
                      //         ListTile(
                      //           title: Text("Rp. 50,000"),
                      //           subtitle: Text("1 Januari 2024"),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
