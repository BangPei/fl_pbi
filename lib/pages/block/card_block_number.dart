import 'package:fl_pbi/library/app_theme.dart';
import 'package:fl_pbi/models/number.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardBlockNumber extends StatelessWidget {
  final Number number;
  final GestureTapCallback? onTap;
  const CardBlockNumber({
    super.key,
    required this.number,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 216, 216, 216),
              spreadRadius: 0.2,
              blurRadius: 2,
              offset: Offset(0, 1),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      number.data['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "Rp. ${number.data['price']}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const Badge(
                  backgroundColor: AppTheme.blue,
                  label: Text("Sold Out"),
                ),
              ],
            ),
            const Divider(),
            ListTile(
              dense: true,
              contentPadding: const EdgeInsets.all(0),
              leading: const Icon(
                FontAwesomeIcons.building,
                color: AppTheme.blue,
                size: 50,
              ),
              title: RichText(
                text: const TextSpan(
                  text: "Pemilik : ",
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.darkerText,
                  ),
                  children: [
                    TextSpan(
                      text: "--",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              subtitle: Text(
                "Luas Area : ${number.data['width']} x ${number.data['length']} = ${number.data['wide']} m2",
                style: const TextStyle(fontSize: 14),
              ),
            )
          ],
        ),
      ),
    );
  }
}
