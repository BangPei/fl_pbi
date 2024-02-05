import 'package:fl_pbi/library/library_file.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class Report {
  final String? label;
  final Widget? icon;
  final GestureTapCallback? onTap;
  Report({this.icon, this.onTap, this.label});

  List<Report> data(BuildContext context) {
    return [
      Report(
        label: "Parkir",
        icon: Icon(
          Icons.car_crash,
          size: 35,
          color: AppTheme.nearlyDarkRed.withOpacity(0.7),
        ),
        onTap: () {
          context.goNamed('report',pathParameters: {'reportType':"parking"});
        },
      ),
      Report(
        label: "IPL",
        icon: Icon(
          FontAwesomeIcons.building,
          size: 35,
          color: AppTheme.nearlyDarkRed.withOpacity(0.7),
        ),
        onTap: () {
          context.goNamed('report',pathParameters: {'reportType':"ipl"});
        },
      ),
      Report(
        label: "IPL Blok",
        icon: Icon(
          FontAwesomeIcons.buildingCircleArrowRight,
          size: 35,
          color: AppTheme.nearlyDarkRed.withOpacity(0.7),
        ),
        onTap: () {},
      ),
    ];
  }
}
