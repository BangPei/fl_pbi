import 'package:fl_pbi/library/library_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jiffy/jiffy.dart';

class ListSummaryScreen<T> extends StatelessWidget {
  final List<T> list;
  final Function(int)? onConfirm;
  final Function(int)? onTap;
  const ListSummaryScreen(
      {super.key, required this.list, this.onConfirm, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemBuilder: (context, i) {
          dynamic data = list[i];
          IconData icon = FontAwesomeIcons.arrowRightToBracket;
          Color color = AppTheme.blue;
          String positive = "";
          if (data?.type == 1) {
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
                key: ValueKey(data.id),
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) async {
                        await Common.modalConfirm(
                          context,
                          onConfirm: () => onConfirm!(data.id),
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
                                (data.code == null || data.code == "")
                                    ? 'Code : --'
                                    : "Code : ${data.code}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Visibility(
                                visible: (data.code != "") ? true : false,
                                replacement: const SizedBox.shrink(),
                                child: GestureDetector(
                                  onTap: () async {
                                    await Clipboard.setData(
                                        ClipboardData(text: data.code!));
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
                              data.type == 1 ? "masuk" : "keluar",
                            ),
                          )
                        ],
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "$positive Rp. ${Common.oCcy.format(data.amount)}",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                          color: data.type == 1 ? null : AppTheme.nearlyDarkRed,
                        ),
                      ),
                      dense: true,
                      visualDensity: const VisualDensity(vertical: -2),
                      subtitle: Text(Jiffy.parse(data.date!)
                          .format(pattern: "dd MMMM yyyy")),
                      leading: Icon(FontAwesomeIcons.dollarSign, color: color),
                      trailing: Icon(icon, color: color),
                      onTap: () => onTap!(data.id),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Text('Note : ${data.note ?? data.remark ?? ""}'),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: list.length,
      ),
    );
  }
}
