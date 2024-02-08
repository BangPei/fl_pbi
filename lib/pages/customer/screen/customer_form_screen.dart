import 'package:fl_pbi/library/library_file.dart';
import 'package:fl_pbi/widget/widget_file.dart';
import 'package:flutter/material.dart';

class CustomerFormScreen extends StatefulWidget {
  const CustomerFormScreen({super.key});

  @override
  State<CustomerFormScreen> createState() => _CustomerFormScreenState();
}

class _CustomerFormScreenState extends State<CustomerFormScreen> {
  String? ktpBase64;
  @override
  Widget build(BuildContext context) {
    return CustomForm(
      showCard: false,
      title: "Form Customer",
      onSubmit: () {},
      buttonTitle: "Simpan",
      children: [
        ImageCamera(
          title: "KTP",
          onTap: (str) {},
          base64: ktpBase64,
        ),
        CustomFormField(
          title: "Nama Lengkap",
          textForm: TextFormField(
            validator: ValidForm.emptyValue,
            keyboardType: TextInputType.number,
            decoration: TextFormDecoration.box(),
            onChanged: (val) {},
          ),
        ),
        CustomFormField(
          title: "Nama Lengkap",
          textForm: TextFormField(
            validator: ValidForm.emptyValue,
            keyboardType: TextInputType.number,
            decoration: TextFormDecoration.box(),
            onChanged: (val) {},
          ),
        ),
      ],
    );
  }
}
