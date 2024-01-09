import 'package:fl_pbi/library/app_theme.dart';
import 'package:fl_pbi/library/common.dart';
import 'package:fl_pbi/pages/parking/bloc/park_bloc.dart';
import 'package:fl_pbi/pages/parking/data/parking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jiffy/jiffy.dart';

class ListSummaryScreen extends StatefulWidget {
  const ListSummaryScreen({super.key});

  @override
  State<ListSummaryScreen> createState() => _ListSummaryScreenState();
}

class _ListSummaryScreenState extends State<ListSummaryScreen> {
  @override
  void initState() {
    context.read<ParkingBloc>().add(OnGetSummary());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParkingBloc, ParkingState>(
      builder: (context, state) {
        if (state.listLoading) {
          return const Text("Loading");
        } else if (state.isError) {
          return const Text("Error");
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemBuilder: (context, i) {
              Parking park = state.parks![i];
              IconData icon = FontAwesomeIcons.arrowRightToBracket;
              Color color = AppTheme.blue;
              String positive = "";
              if (park.type == 1) {
                icon = FontAwesomeIcons.arrowRightToBracket;
                color = AppTheme.blue;
                positive = "";
              } else {
                icon = FontAwesomeIcons.arrowRightFromBracket;
                color = AppTheme.nearlyDarkRed;
                positive = "-";
              }
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    borderRadius: BorderRadius.circular(15),
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
                    title: Text(
                      "$positive Rp. ${Common.oCcy.format(park.amount)}",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                        color: park.type == 1 ? null : AppTheme.nearlyDarkRed,
                      ),
                    ),
                    subtitle: Text(Jiffy.parse(park.date!)
                        .format(pattern: "dd MMMM yyyy")),
                    leading: Icon(FontAwesomeIcons.dollarSign, color: color),
                    trailing: Icon(icon, color: color),
                  ),
                ),
              );
            },
            itemCount: (state.parks ?? []).length,
          ),
        );
      },
    );
  }
}
