import 'package:fl_pbi/library/library_file.dart';
import 'package:fl_pbi/models/models.dart';
import 'package:flutter/material.dart';

class ListTransaction extends StatelessWidget {
  final Function(Trans) onTap;
  final List<Trans> trans;
  final int type;
  const ListTransaction({
    super.key,
    required this.trans,
    required this.type,
    required this.onTap,
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
              color: const Color.fromARGB(255, 252, 253, 253),
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: type == 1
                      ? const Color.fromARGB(255, 114, 100, 240)
                      : const Color.fromARGB(255, 241, 106, 96),
                  spreadRadius: 0.2,
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                )
              ],
            ),
            child: ListTile(
              dense: true,
              visualDensity: const VisualDensity(vertical: -3),
              subtitle: Text(
                "Rp. ${Common.oCcy.format(tran.amount ?? 0)}",
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppTheme.blue,
                ),
              ),
              title: Text(
                "${tran.month ?? ''} ${tran.year ?? ''}",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_outlined,
                color: AppTheme.grey,
              ),
              onTap: () => onTap(tran),
            ),
          ),
        );
      },
    );
  }
}
