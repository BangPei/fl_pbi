import 'package:fl_pbi/library/common.dart';
import 'package:fl_pbi/library/text_form_decoration.dart';
import 'package:fl_pbi/widget.dart/custom_form.dart';
import 'package:fl_pbi/widget.dart/custom_formfield.dart';
import 'package:fl_pbi/widget.dart/custome_datepicker.dart';
import 'package:fl_pbi/widget.dart/form_title.dart';
import 'package:flutter/material.dart';

class PerjanjianHakGunaPakai extends StatefulWidget {
  const PerjanjianHakGunaPakai({super.key});

  @override
  State<PerjanjianHakGunaPakai> createState() => _PerjanjianHakGunaPakaiState();
}

class _PerjanjianHakGunaPakaiState extends State<PerjanjianHakGunaPakai> {
  TextEditingController createdDateController = TextEditingController();
  FocusNode createdDateNode = FocusNode();
  TextEditingController dateBirthController = TextEditingController();
  FocusNode dateBirthNode = FocusNode();
  TextEditingController validDateController = TextEditingController();
  FocusNode validDateNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return CustomForm(
      title: 'Form Perjanjian Hak Guna',
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
                  title: "Ditandatangani di",
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
        const FormTitle(title: 'PIHAK PERTAMA'),
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
        const FormTitle(title: 'PIHAK KEDUA'),
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
                  title: "No. Tlp",
                  textForm: TextFormField(
                    decoration: TextFormDecoration.box(),
                    validator: ValidForm.emptyValue,
                    onChanged: (vals) {},
                  ),
                ),
                CustomFormField(
                  title: "Pekerjaaan",
                  textForm: TextFormField(
                    decoration: TextFormDecoration.box(),
                    validator: ValidForm.emptyValue,
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
                  title: "Luas Kios",
                  textForm: TextFormField(
                    decoration: TextFormDecoration.box(),
                    validator: ValidForm.emptyValue,
                    onChanged: (vals) {},
                  ),
                ),
                CustomFormField(
                  title: "Jangka Waktu Hak Guna",
                  textForm: TextFormField(
                    decoration: TextFormDecoration.box(),
                    validator: ValidForm.emptyValue,
                    onChanged: (vals) {},
                  ),
                ),
                CustomFormField(
                  title: "Tanda Daftar Hak Guna Perunit",
                  textForm: TextFormField(
                    decoration: TextFormDecoration.box(),
                    validator: ValidForm.emptyValue,
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
                  title: "Sewa Bulanan Selama Hak Guna",
                  textForm: TextFormField(
                    decoration: TextFormDecoration.box(),
                    validator: ValidForm.emptyValue,
                    onChanged: (vals) {},
                  ),
                ),
                CustomFormField(
                  title: "Tagihan Iuran Pemakaian Listrik",
                  textForm: TextFormField(
                    decoration: TextFormDecoration.box(),
                    validator: ValidForm.emptyValue,
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