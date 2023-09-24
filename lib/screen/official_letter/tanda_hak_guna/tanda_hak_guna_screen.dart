import 'package:fl_pbi/library/common.dart';
import 'package:fl_pbi/library/text_form_decoration.dart';
import 'package:fl_pbi/widget.dart/custom_form.dart';
import 'package:fl_pbi/widget.dart/custom_formfield.dart';
import 'package:fl_pbi/widget.dart/custome_datepicker.dart';
import 'package:fl_pbi/widget.dart/form_title.dart';
import 'package:flutter/material.dart';

class TandaHakGunaScreen extends StatefulWidget {
  const TandaHakGunaScreen({super.key});

  @override
  State<TandaHakGunaScreen> createState() => _TandaHakGunaScreenState();
}

class _TandaHakGunaScreenState extends State<TandaHakGunaScreen> {
  TextEditingController createdDateController = TextEditingController();
  FocusNode createdDateNode = FocusNode();
  TextEditingController dateBirthController = TextEditingController();
  FocusNode dateBirthNode = FocusNode();
  TextEditingController validDateController = TextEditingController();
  FocusNode validDateNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return CustomForm(
      title: 'Form Tanda Hak Guna Pakai',
      showCard: false,
      onSubmit: () {},
      action: IconButton(
        icon: const Icon(Icons.download),
        onPressed: () {},
      ),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5),
            child: Column(
              children: [
                CustomFormField(
                  title: "Nomor Surat",
                  textForm: TextFormField(
                    decoration: TextFormDecoration.box(),
                    validator: ValidForm.emptyValue,
                    onChanged: (vals) {},
                  ),
                ),
                CustomFormField(
                  title: "Tempat Dibuat",
                  textForm: TextFormField(
                    decoration: TextFormDecoration.box(),
                    validator: ValidForm.emptyValue,
                    onChanged: (vals) {},
                  ),
                ),
                CustomFormField(
                  title: "Tanggal Dibuat",
                  textForm: CustomDatePicker(
                    validator: ValidForm.emptyValue,
                    focusNode: createdDateNode,
                    onCloseDatepicker: (val) {},
                    controller: createdDateController,
                  ),
                ),
              ],
            ),
          ),
        ),
        const FormTitle(title: 'Data Pengelola'),
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5),
            child: Column(
              children: [
                CustomFormField(
                  title: "Nama",
                  textForm: TextFormField(
                    decoration: TextFormDecoration.box(),
                    validator: ValidForm.emptyValue,
                    onChanged: (vals) {},
                  ),
                ),
                CustomFormField(
                  title: "Tanggal Lahir",
                  textForm: CustomDatePicker(
                    validator: ValidForm.emptyValue,
                    focusNode: dateBirthNode,
                    onCloseDatepicker: (val) {},
                    controller: dateBirthController,
                  ),
                ),
                CustomFormField(
                  title: "No. KTP",
                  textForm: TextFormField(
                    validator: ValidForm.emptyValue,
                    keyboardType: TextInputType.number,
                    inputFormatters: [Common.ktpFormat],
                    decoration: TextFormDecoration.box(),
                    onChanged: (vals) {},
                  ),
                ),
                CustomFormField(
                  title: "No.Tlp",
                  textForm: TextFormField(
                    validator: ValidForm.emptyValue,
                    onChanged: (vals) {},
                    decoration: TextFormDecoration.box(),
                  ),
                ),
                CustomFormField(
                  title: "Posisi / Jabatan",
                  textForm: TextFormField(
                    validator: ValidForm.emptyValue,
                    onChanged: (vals) {},
                    decoration: TextFormDecoration.box(),
                  ),
                ),
                CustomFormField(
                  title: "Alamat",
                  textForm: TextFormField(
                    validator: ValidForm.emptyValue,
                    onChanged: (vals) {},
                    minLines: 3,
                    maxLines: 3,
                    decoration: TextFormDecoration.box(),
                  ),
                ),
              ],
            ),
          ),
        ),
        const FormTitle(title: 'Data Pembeli / Penyewa'),
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5),
            child: Column(
              children: [
                CustomFormField(
                  title: "Nama",
                  textForm: TextFormField(
                    decoration: TextFormDecoration.box(),
                    validator: ValidForm.emptyValue,
                    onChanged: (vals) {},
                  ),
                ),
                CustomFormField(
                  title: "No. KTP",
                  textForm: TextFormField(
                    validator: ValidForm.emptyValue,
                    keyboardType: TextInputType.number,
                    inputFormatters: [Common.ktpFormat],
                    decoration: TextFormDecoration.box(),
                    onChanged: (vals) {},
                  ),
                ),
                CustomFormField(
                  title: "Alamat",
                  textForm: TextFormField(
                    validator: ValidForm.emptyValue,
                    onChanged: (vals) {},
                    minLines: 3,
                    maxLines: 3,
                    decoration: TextFormDecoration.box(),
                  ),
                ),
              ],
            ),
          ),
        ),
        const FormTitle(title: 'Data Kios'),
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5),
            child: Column(
              children: [
                CustomFormField(
                  title: "Lokasi Kios",
                  textForm: TextFormField(
                    decoration: TextFormDecoration.box(),
                    validator: ValidForm.emptyValue,
                    onChanged: (vals) {},
                  ),
                ),
                CustomFormField(
                  title: "Blok Kios",
                  textForm: TextFormField(
                    validator: ValidForm.emptyValue,
                    decoration: TextFormDecoration.box(),
                    onChanged: (vals) {},
                  ),
                ),
                CustomFormField(
                  title: "Nomor Kios",
                  textForm: TextFormField(
                    validator: ValidForm.emptyValue,
                    decoration: TextFormDecoration.box(),
                    onChanged: (vals) {},
                  ),
                ),
                CustomFormField(
                  title: "Jumlah Kios",
                  textForm: TextFormField(
                    validator: ValidForm.emptyValue,
                    decoration: TextFormDecoration.box(),
                    onChanged: (vals) {},
                  ),
                ),
                CustomFormField(
                  title: "Masa Berlaku",
                  textForm: CustomDatePicker(
                    validator: ValidForm.emptyValue,
                    focusNode: validDateNode,
                    onCloseDatepicker: (val) {},
                    controller: validDateController,
                  ),
                ),
                CustomFormField(
                  title: "Nomor Perjanjian Hak Guna Pakai",
                  textForm: TextFormField(
                    validator: ValidForm.emptyValue,
                    decoration: TextFormDecoration.box(),
                    onChanged: (vals) {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
