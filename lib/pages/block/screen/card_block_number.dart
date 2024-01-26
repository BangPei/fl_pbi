import 'dart:convert';
import 'package:fl_pbi/library/app_theme.dart';
import 'package:fl_pbi/pages/block/data/block_details.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class CardBlockNumber extends StatelessWidget {
  final BlockDetail blockDetail;
  final GestureTapCallback? onTap;
  const CardBlockNumber({
    super.key,
    required this.blockDetail,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final oCcy = NumberFormat("#,###", "en_US");
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
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
                        blockDetail.name ?? "",
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "Rp. ${oCcy.format(blockDetail.price)}",
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
                leading: (blockDetail.picture == null)
                    ? const Icon(
                        FontAwesomeIcons.building,
                        color: AppTheme.blue,
                        size: 50,
                      )
                    : Container(
                        height: 200,
                        width: 60,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          image: (blockDetail.isBase64 == true)
                              ? DecorationImage(
                                  image: MemoryImage(
                                      base64Decode(blockDetail.picture!)),
                                  fit: BoxFit.cover,
                                )
                              : DecorationImage(
                                  image: NetworkImage(blockDetail.picture!),
                                  fit: BoxFit.cover,
                                ),
                        )),
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
                  "Luas Area : ${blockDetail.width} x ${blockDetail.length} = ${blockDetail.wide} m2",
                  style: const TextStyle(fontSize: 14),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
