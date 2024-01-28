import 'package:fl_pbi/library/library_file.dart';
import 'package:fl_pbi/pages/finance/screen/finance_total_card.dart';
import 'package:fl_pbi/widget/widget_file.dart';
import 'package:flutter/material.dart';

class FinanceScreen extends StatefulWidget {
  const FinanceScreen({super.key});

  @override
  State<FinanceScreen> createState() => _FinanceScreenState();
}

class _FinanceScreenState extends State<FinanceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const CustomAppbar(
        title: "Keuangan",
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const FinanceTotalCard(),
                const FormTitle(
                  title: "Transaksi Terakhir Parkir",
                  fontSize: 14,
                  padding: EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 189, 188, 188),
                          spreadRadius: 0.2,
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        )
                      ],
                    ),
                    child: const Column(
                      children: [
                        ListTile(
                          minVerticalPadding: 0,
                          title: Text("Rp. 270,000"),
                          subtitle: Text("1 Januari 2024"),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Divider(),
                        ),
                        ListTile(
                          title: Text("Rp. 50,000"),
                          subtitle: Text("1 Januari 2024"),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
