import 'package:fl_pbi/library/text_form_decoration.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CustomDatePicker extends StatefulWidget {
  final String formControlName;
  final FocusNode focusNode;
  final FormGroup formGroup;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final Function(DateTime)? onCloseDatepicker;
  const CustomDatePicker(
      {super.key,
      required this.formControlName,
      required this.focusNode,
      required this.formGroup,
      this.initialDate,
      this.firstDate,
      this.lastDate,
      this.onCloseDatepicker});

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  @override
  Widget build(BuildContext context) {
    return ReactiveTextField(
      formControlName: widget.formControlName,
      decoration: TextFormDecoration.box(
        suffixIcon: InkWell(
          onTap: () async {
            widget.focusNode.unfocus();
            if (widget.formGroup.control(widget.formControlName).value ==
                null) {
              final DateTime? picked = await showDate(
                context,
                initialDate: widget.initialDate,
                firstDate: widget.firstDate,
                lastDate: widget.lastDate,
              );
              if (picked != null) {
                setState(() {
                  widget.formGroup.control(widget.formControlName).value =
                      picked;
                });
              }
            } else {
              setState(() {
                widget.formGroup.control(widget.formControlName).value = null;
                widget.focusNode.canRequestFocus = true;
              });
            }
          },
          child: widget.formGroup.control(widget.formControlName).value == null
              ? const Icon(
                  FontAwesomeIcons.calendarCheck,
                  color: Colors.blue,
                )
              : const Icon(
                  FontAwesomeIcons.xmark,
                  color: Colors.red,
                ),
        ),
      ),
      valueAccessor: DateTimeValueAccessor(
        dateTimeFormat: DateFormat('dd MMMM yyyy'),
      ),
      onTap: (val) async {
        final DateTime? picked = await showDate(
          context,
          initialDate: widget.initialDate,
          firstDate: widget.firstDate,
          lastDate: widget.lastDate,
        );
        if (picked != null) {
          widget.formGroup.control(widget.formControlName).value = picked;
          widget.onCloseDatepicker!(picked);
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
