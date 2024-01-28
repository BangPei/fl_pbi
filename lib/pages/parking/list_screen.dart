import 'package:fl_pbi/library/library_file.dart';
import 'package:fl_pbi/pages/parking/bloc/park_bloc.dart';
import 'package:fl_pbi/pages/parking/data/parking.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                          onPressed: (context) async {
                            await Common.modalConfirm(
                              context,
                              onConfirm: () {
                                context
                                    .read<ParkingBloc>()
                                    .add(OnRemovePark(park.id));
                              },
                            );
                          },
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
                              Row(
                                children: [
                                  Text(
                                    (park.code == null || park.code == "")
                                        ? 'Code : --'
                                        : "Code : ${park.code}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Visibility(
                                    visible: (park.code != "") ? true : false,
                                    replacement: const SizedBox.shrink(),
                                    child: GestureDetector(
                                      onTap: () async {
                                        await Clipboard.setData(
                                            ClipboardData(text: park.code!));
                                      },
                                      child: const Icon(
                                        Icons.copy_all_rounded,
                                        color: AppTheme.blue,
                                        size: 18,
                                      ),
                                    ),
                                  )
                                ],
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
                          onTap: () => context.goNamed("parking-form",
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
}
