import 'package:flutter/material.dart';

class CustomFormField extends StatefulWidget {
  final String title;
  final Widget textForm;
  final bool? action;
  final Function(bool)? onChangeSwitch;
  const CustomFormField({
    super.key,
    required this.title,
    required this.textForm,
    this.action,
    this.onChangeSwitch,
  });

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5.0,
        vertical: 5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.action == null
              ? Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Expanded(
                      child: SwitchListTile(
                        value: isActive,
                        onChanged: (val) {
                          setState(() {
                            isActive = val;
                            widget.onChangeSwitch!(val);
                          });
                        },
                        activeColor: Colors.blue[400],
                      ),
                    )
                  ],
                ),
          const SizedBox(height: 3),
          widget.textForm,
        ],
      ),
    );
  }
}
