import 'package:fl_pbi/models/offcial_letter.dart';
import 'package:fl_pbi/widget.dart/card_banner.dart';
import 'package:fl_pbi/widget.dart/custom_appbar.dart';
import 'package:fl_pbi/widget.dart/custome_badge.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OfficialLetterScreen extends StatefulWidget {
  const OfficialLetterScreen({super.key});

  @override
  State<OfficialLetterScreen> createState() => _OfficialLetterScreenState();
}

class _OfficialLetterScreenState extends State<OfficialLetterScreen> {
  OfficialLetter officialLetter = OfficialLetter();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomAppbar(
          title: "Surat Resmi",
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: List.generate(
          officialLetter.data().length,
          (index) {
            OfficialLetter letter = officialLetter.data()[index];
            return Padding(
              padding: const EdgeInsets.only(top: 6, left: 6, right: 6),
              child: CardBanner(
                onTap: () => context.push("/${letter.routeName}"),
                title: letter.title ?? "",
                leading: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: CustomeBadge(
                    text: "${index + 1}",
                    borderRadius: BorderRadius.circular(25),
                    height: 30,
                    width: 30,
                  ),
                ),
              ),
            );
          },
          growable: true,
        ),
      ),
    );
  }
}
