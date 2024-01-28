import 'package:fl_pbi/library/library_file.dart';
import 'package:fl_pbi/widget/widget_file.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TitleList extends StatefulWidget {
  final String year, type, title;
  final Function(String) onTapDate;
  const TitleList(
      {super.key,
      required this.year,
      required this.title,
      required this.type,
      required this.onTapDate});

  @override
  State<TitleList> createState() => _TitleListState();
}

class _TitleListState extends State<TitleList> {
  late String year, type;
  @override
  void initState() {
    year = widget.year;
    type = widget.type;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        FormTitle(
          title: widget.title,
          fontSize: 15,
          padding: const EdgeInsets.fromLTRB(20, 20, 5, 20),
        ),
        GestureDetector(
          onTap: () {
            Common.yearPicker(
              selecteYear: int.parse(year),
              context: context,
              onTap: (dt) {
                year = dt.year.toString();
                widget.onTapDate(year);
                setState(() {});
              },
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 7),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 252, 253, 253),
              borderRadius: BorderRadius.circular(6),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(255, 163, 159, 159),
                  spreadRadius: 0.1,
                  blurRadius: 1,
                  offset: Offset(0, 1),
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(year),
                const FaIcon(
                  Icons.arrow_drop_down,
                  size: 30,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
