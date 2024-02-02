import 'package:fl_pbi/library/library_file.dart';
import 'package:fl_pbi/models/models.dart';
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
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        child: Text(
                          "Laporan Transaksi",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 114, 113, 113)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 100,
                            childAspectRatio: 1,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: Report().data().length,
                          itemBuilder: (BuildContext ctx, i) {
                            Report report = Report().data()[i];
                            return ReportBox(
                              label: report.label!,
                              icon: report.icon,
                              onTap: () {},
                            );
                          },
                        ),
                      ),
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
