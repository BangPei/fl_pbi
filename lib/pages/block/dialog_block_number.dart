import 'dart:convert';
import 'dart:io';
import 'package:fl_pbi/library/currency_formater.dart';
import 'package:fl_pbi/library/text_form_decoration.dart';
import 'package:fl_pbi/models/number.dart';
import 'package:fl_pbi/pages/block/bloc/block_form_bloc.dart';
import 'package:fl_pbi/widget.dart/clip_picture.dart';
import 'package:fl_pbi/widget.dart/custom_botton.dart';
import 'package:fl_pbi/widget.dart/custom_form.dart';
import 'package:fl_pbi/widget.dart/custom_formfield.dart';
import 'package:fl_pbi/widget.dart/empty_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

class DialogBlockNumber extends StatefulWidget {
  final String? blockName;
  final Number no;
  const DialogBlockNumber({super.key, this.blockName, required this.no});

  @override
  State<DialogBlockNumber> createState() => _DialogBlockNumberState();
}

class _DialogBlockNumberState extends State<DialogBlockNumber> {
  String? kiosPicture;
  var widthController = TextEditingController();
  var lengthController = TextEditingController();
  var priceController = TextEditingController();

  @override
  void initState() {
    widthController.text = (widget.no.data?['width'] ?? 0).toString();
    lengthController.text = (widget.no.data?['length'] ?? 0).toString();
    priceController.text = (widget.no.data?['price'] ?? 0).toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "Form Kios Blok ${widget.blockName} No ${widget.no.name}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 9),
            const Divider(),
            const SizedBox(height: 9),
            Row(
              children: [
                Expanded(
                  child: CustomFormField(
                    title: "Lebar Kios",
                    textForm: TextFormField(
                      controller: widthController,
                      validator: ValidForm.emptyValue,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [DecimalInputFormatter(decimalRange: 2)],
                      onChanged: (val) {
                        context.read<BlockFormBloc>().add(OnChangedName(val));
                      },
                      decoration: TextFormDecoration.box(),
                    ),
                  ),
                ),
                Expanded(
                  child: CustomFormField(
                    title: "Panjang Kios",
                    textForm: TextFormField(
                      controller: lengthController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CurrencyInputFormatter()
                      ],
                      validator: ValidForm.emptyValue,
                      onChanged: (val) {
                        context.read<BlockFormBloc>().add(OnChangedName(val));
                      },
                      decoration: TextFormDecoration.box(),
                    ),
                  ),
                ),
              ],
            ),
            CustomFormField(
              title: "Harga",
              textForm: TextFormField(
                controller: priceController,
                keyboardType: TextInputType.number,
                validator: ValidForm.emptyValue,
                onChanged: (val) {
                  context.read<BlockFormBloc>().add(OnChangedName(val));
                },
                decoration: TextFormDecoration.box(),
              ),
            ),
            CustomFormField(
              title: "Gabar Kios",
              textForm: kiosPicture != null
                  ? ClipPicture(
                      height: 40,
                      onTap: () => pickPicture(),
                      child: Image.memory(
                        base64Decode(kiosPicture!),
                        fit: BoxFit.fill,
                      ),
                    )
                  : widget.no.data?['picture'] != null
                      ? ClipPicture(
                          height: 40,
                          onTap: () => pickPicture(),
                          child: Image.network(
                            widget.no.data['picture'],
                            fit: BoxFit.cover,
                          ),
                        )
                      : EmptyImageScreen(onTap: () => pickPicture()),
            ),
            const CustomButton(
              title: Text("Simpan"),
              icon: Icon(Icons.save_outlined),
            )
          ],
        ),
      ),
    );
  }

  pickPicture() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      String path = photo.path;
      var result = await FlutterImageCompress.compressWithFile(
        File(path).absolute.path,
        minWidth: 1000,
        minHeight: 500,
        quality: 94,
        // rotate: 90,
      );
      kiosPicture = base64Encode(result as List<int>);
      setState(() {});
    } else {
      // ignore: avoid_print
      print("err");
    }
  }
}
