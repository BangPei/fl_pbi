import 'package:fl_pbi/library/library_file.dart';
import 'package:fl_pbi/pages/finance/data/finance.dart';
import 'package:fl_pbi/widget/widget_file.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jiffy/jiffy.dart';

class FinanceTotalCard extends StatefulWidget {
  final Finance data;
  const FinanceTotalCard({super.key, required this.data});

  @override
  State<FinanceTotalCard> createState() => _FinanceTotalCardState();
}

class _FinanceTotalCardState extends State<FinanceTotalCard> {
  bool _visible = false;
  IconData _iconData = Icons.visibility_off;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: AppTheme.white,
          gradient: AppTheme.gradient,
          boxShadow: const [AppTheme.boxShadow],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Periode : ${Jiffy.now().format(pattern: "dd MMMM yyyy")}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppTheme.white,
                      fontSize: 17,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _visible = !_visible;
                        _iconData =
                            _visible ? Icons.visibility : Icons.visibility_off;
                      });
                    },
                    icon: Icon(
                      _iconData,
                      color: AppTheme.white,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Rp. ${_visible ? Common.oCcy.format(widget.data.rest) : "*********"}",
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.white,
                    ),
                  ),
                  const Text(
                    'Total Saldo',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.white,
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 10.0, left: 20, right: 20),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  MoneyWidget(
                    data:
                        "Rp. ${_visible ? Common.oCcy.format(widget.data.totalPark) : "*********"}",
                    title: "Saldo Parkir",
                    icon: Image.asset(
                      Common.imageEaten,
                      scale: 2.5,
                    ),
                    onTap: () => context.goNamed('parking'),
                  ),
                  MoneyWidget(
                    data:
                        "Rp. ${_visible ? Common.oCcy.format(widget.data.totalIpl) : "*********"}",
                    title: "Saldo IPL",
                    icon: Image.asset(
                      Common.imageBurned,
                      scale: 2.5,
                    ),
                    onTap: () => context.goNamed('ipl'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
