import 'package:fl_pbi/library/app_theme.dart';
import 'package:fl_pbi/models/trans.dart';
import 'package:flutter/material.dart';

class ListTransaction extends StatelessWidget {
  final List<Trans> trans;
  const ListTransaction({
    super.key,
    required this.trans,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemCount: trans.length,
      itemBuilder: (context, i) {
        Trans tran = trans[i];
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 4.0,
            horizontal: 16,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(255, 216, 216, 216),
                  spreadRadius: 0.2,
                  blurRadius: 2,
                  offset: Offset(0, 1),
                )
              ],
            ),
            child: ListTile(
              dense: true,
              visualDensity: const VisualDensity(vertical: -3),
              subtitle: Text(
                "Rp. ${(tran.amount ?? 0)}",
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppTheme.blue,
                ),
              ),
              title: Text("${tran.month ?? ''} ${tran.year ?? ''}"),
            ),
          ),
        );
      },
    );
  }
}
