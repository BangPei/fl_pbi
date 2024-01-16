import 'package:fl_pbi/library/app_theme.dart';
import 'package:fl_pbi/library/common.dart';
import 'package:fl_pbi/pages/parking/bloc/park_bloc.dart';
import 'package:fl_pbi/pages/parking/data/parking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
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
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.isError) {
          return Center(child: Text(state.errorMessage ?? "Error"));
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
                  child: Slidable(
                    key: ValueKey(park.id),
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) async => await confirm(park.id!),
                          backgroundColor: AppTheme.nearlyDarkRed,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Hapus',
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                (park.code == null || park.code == "")
                                    ? 'Code : --'
                                    : "Code : ${park.code}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(width: 5),
                              Badge(
                                backgroundColor: color,
                                label: Text(
                                  park.type == 1 ? "masuk" : "keluar",
                                ),
                              )
                            ],
                          ),
                        ),
                        ListTile(
                          title: Text(
                            "$positive Rp. ${Common.oCcy.format(park.amount)}",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 17,
                              color: park.type == 1
                                  ? null
                                  : AppTheme.nearlyDarkRed,
                            ),
                          ),
                          dense: true,
                          visualDensity: const VisualDensity(vertical: -2),
                          subtitle: Text(Jiffy.parse(park.date!)
                              .format(pattern: "dd MMMM yyyy")),
                          leading:
                              Icon(FontAwesomeIcons.dollarSign, color: color),
                          trailing: Icon(icon, color: color),
                          onTap: () => context.goNamed("keuangan-form",
                              extra: {"type": park.type, "id": park.id}),
                        ),
                      ],
                    ),
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

  confirm(int id) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Transaksi akan dihapus, Yakin?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
                context.read<ParkingBloc>().add(OnRemovePark(id));
              },
              child: const Text('Yes'),
            )
          ],
        );
      },
    );
    return confirmed;
  }
}
