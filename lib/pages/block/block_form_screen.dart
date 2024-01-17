import 'package:fl_pbi/library/text_form_decoration.dart';
import 'package:fl_pbi/widget.dart/custom_form.dart';
import 'package:fl_pbi/widget.dart/custom_formfield.dart';
import 'package:fl_pbi/widget.dart/form_title.dart';
import 'package:flutter/material.dart';

class BlockFormScreen extends StatefulWidget {
  final int? id;
  const BlockFormScreen({super.key, this.id});

  @override
  State<BlockFormScreen> createState() => _BlockFormScreenState();
}

class _BlockFormScreenState extends State<BlockFormScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomForm(
      title: "Form Blok Kios/Lahan",
      onSubmit: () {},
      showCard: false,
      buttonTitle: "Simpan",
      children: [
        CustomFormField(
          title: "Nama Blok",
          textForm: TextFormField(
            validator: ValidForm.emptyValue,
            onChanged: (val) {},
            decoration: TextFormDecoration.box(),
          ),
        ),
        const FormTitle(
          title: 'Data Kios/Lahan',
          fontSize: 15,
        ),
      ],
    );
  }
}
