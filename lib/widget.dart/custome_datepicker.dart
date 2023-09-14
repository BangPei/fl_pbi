import 'package:fl_pbi/library/text_form_decoration.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jiffy/jiffy.dart';

class CustomDatePicker extends StatefulWidget {
  final String formControlName;
  final FocusNode focusNode;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? dateFormat;
  final Function(String)? onCloseDatepicker;
  const CustomDatePicker({
    super.key,
    required this.formControlName,
    required this.focusNode,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.onCloseDatepicker,
    this.dateFormat,
  });

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      decoration: TextFormDecoration.box(
        suffixIcon: InkWell(
          onTap: () async {
            widget.focusNode.unfocus();
            // if (widget.formGroup.control(widget.formControlName).value ==
            //     null) {
            //   final DateTime? picked = await showDate(
            //     context,
            //     initialDate: widget.initialDate,
            //     firstDate: widget.firstDate,
            //     lastDate: widget.lastDate,
            //   );
            //   if (picked != null) {
            //     String dateString = Jiffy.parseFromDateTime(picked)
            //         .format(pattern: widget.dateFormat ?? "dd MMMM yyyy");
            //     setState(() {
            //       widget.formGroup.control(widget.formControlName).value =
            //           dateString;
            //     });
            //   }
            // } else {
            //   setState(() {
            //     widget.formGroup.control(widget.formControlName).value = null;
            //     widget.focusNode.canRequestFocus = true;
            //   });
            // }
          },
          child: const Icon(
            FontAwesomeIcons.xmark,
            color: Colors.red,
          ),
        ),
      ),
      // valueAccessor: DateTimeValueAccessor(
      //   dateTimeFormat: DateFormat('dd MMMM yyyy'),
      // ),
      onTap: () async {
        final DateTime? picked = await showDate(
          context,
          initialDate: widget.initialDate,
          firstDate: widget.firstDate,
          lastDate: widget.lastDate,
        );
        if (picked != null) {
          String dateString = Jiffy.parseFromDateTime(picked)
              .format(pattern: widget.dateFormat ?? "dd MMMM yyyy");
          // widget.formGroup.control(widget.formControlName).value = dateString;
          widget.onCloseDatepicker ?? (dateString);
          setState(() {});
        }
      },
    );
  }

  Future<DateTime?> showDate(context,
      {DateTime? initialDate, DateTime? firstDate, DateTime? lastDate}) async {
    return await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(1900),
      lastDate: lastDate ?? DateTime(3000),
    );
  }
}
