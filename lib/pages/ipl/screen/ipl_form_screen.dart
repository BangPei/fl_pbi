import 'package:fl_pbi/library/text_form_decoration.dart';
import 'package:fl_pbi/widget.dart/custom_form.dart';
import 'package:fl_pbi/widget.dart/custom_formfield.dart';
import 'package:fl_pbi/widget.dart/custome_datepicker.dart';
import 'package:flutter/material.dart';

class IPLFormScreen extends StatefulWidget {
  final int? id;
  const IPLFormScreen({super.key, this.id});

  @override
  State<IPLFormScreen> createState() => _IPLFormScreenState();
}

class _IPLFormScreenState extends State<IPLFormScreen> {
  late FocusNode dateFocusNode;
  String? evidentBase64;
  TextEditingController dateController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController remarkController = TextEditingController();

  @override
  void initState() {
    dateFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    dateFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomForm(
      title: "IPL Form",
      onSubmit: () {},
      buttonTitle: "Simpan",
      children: [
        CustomFormField(
          title: "Tanggal",
          textForm: CustomDatePicker(
            focusNode: dateFocusNode,
            validator: ValidForm.emptyValue,
            onCloseDatepicker: (val) {},
            controller: dateController,
          ),
        ),
        CustomFormField(
          title: "Jumlah Uang",
          textForm: TextFormField(
            controller: amountController,
            validator: ValidForm.emptyValue,
            keyboardType: TextInputType.number,
            decoration: TextFormDecoration.box(),
            onChanged: (val) {},
          ),
        ),
        CustomFormField(
          title: "Keterangan",
          textForm: TextFormField(
            controller: remarkController,
            validator: ValidForm.emptyValue,
            decoration: TextFormDecoration.box(),
            onChanged: (val) {},
          ),
        ),
        // CustomFormField(
        //         title: "Lampiran",
        //         textForm: evidentBase64 != null
        //             ? ClipPicture(
        //                 height: 40,
        //                 onTap: () => Common.pickPicture(SOURCE.camera),
        //                 child: Image.memory(
        //                   base64Decode(evidentBase64!),
        //                   fit: BoxFit.fill,
        //                 ),
        //               )
        //             : state.park?.picture != null
        //                 ? ClipPicture(
        //                     height: 40,
        //                    onTap: () => Common.pickPicture(SOURCE.camera),
        //                     child: Image.network(
        //                       state.park!.picture!,
        //                       fit: BoxFit.cover,
        //                     ),
        //                   )
        //                 : EmptyImageScreen(onTap: () => Common.pickPicture(SOURCE.camera)),
        //       ),
      ],
    );
  }
}
