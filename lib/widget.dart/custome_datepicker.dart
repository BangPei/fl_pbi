import 'package:fl_pbi/library/text_form_decoration.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jiffy/jiffy.dart';

class CustomDatePicker extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? dateFormat;
  final FormFieldValidator<String>? validator;
  final Function(DateTime?) onCloseDatepicker;
  const CustomDatePicker({
    super.key,
    required this.focusNode,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    required this.onCloseDatepicker,
    this.dateFormat,
    required this.controller,
    this.validator,
  });

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime? dateTime;
  @override
  void initState() {
    if (widget.controller.text.isNotEmpty) {
      dateTime =
          Jiffy.parse(widget.controller.text, pattern: "dd MMMM yyyy").dateTime;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      validator: widget.validator,
      controller: widget.controller,
      decoration: TextFormDecoration.box(
        suffixIcon: InkWell(
          onTap: () async {
            widget.focusNode.unfocus();
            if (dateTime == null) {
              final DateTime? picked = await showDate(
                context,
                initialDate: widget.initialDate,
                firstDate: widget.firstDate,
                lastDate: widget.lastDate,
              );
              if (picked != null) {
                setState(() {
                  dateTime = picked;
                });
              }
            } else {
              setState(() {
                dateTime = null;
                widget.focusNode.canRequestFocus = true;
              });
            }
            widget.onCloseDatepicker(dateTime);
            widget.controller.text = dateTime == null
                ? ""
                : Jiffy.parseFromDateTime(dateTime!).format(
                    pattern: "dd MMMM yyyy",
                  );
            setState(() {});
          },
          child: dateTime == null
              ? const Icon(
                  FontAwesomeIcons.calendar,
                  color: Colors.blueAccent,
                )
              : const Icon(
                  FontAwesomeIcons.xmark,
                  color: Colors.red,
                ),
        ),
      ),
      onTap: () async {
        final DateTime? picked = await showDate(
          context,
          initialDate: widget.initialDate,
          firstDate: widget.firstDate,
          lastDate: widget.lastDate,
        );
        if (picked != null) {
          dateTime = picked;
          widget.controller.text = dateTime == null
              ? ""
              : Jiffy.parseFromDateTime(dateTime!).format(
                  pattern: "dd MMMM yyyy",
                );
          widget.onCloseDatepicker(picked);
          setState(() {});
        }
      },
    );
  }

  Future<DateTime?> showDate(context,
      {DateTime? initialDate, DateTime? firstDate, DateTime? lastDate}) async {
    return await showDatePicker(
      context: context,
      initialDate: initialDate ?? dateTime ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(1900),
      lastDate: lastDate ?? DateTime(3000),
    );
  }
}
