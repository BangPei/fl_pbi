import 'dart:convert';
import 'dart:io';
import 'package:fl_pbi/library/text_form_decoration.dart';
import 'package:fl_pbi/pages/block/data/block_details.dart';
import 'package:fl_pbi/widget/clip_picture.dart';
import 'package:fl_pbi/widget/custom_botton.dart';
import 'package:fl_pbi/widget/custom_form.dart';
import 'package:fl_pbi/widget/custom_formfield.dart';
import 'package:fl_pbi/widget/empty_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

class DialogBlockNumber extends StatefulWidget {
  final String? blockName;
  final BlockDetail detail;
  final Function(BlockDetail)? onPress;
  const DialogBlockNumber(
      {super.key, this.blockName, this.onPress, required this.detail});

  @override
  State<DialogBlockNumber> createState() => _DialogBlockNumberState();
}

class _DialogBlockNumberState extends State<DialogBlockNumber> {
  String? kiosPicture;
  BlockDetail detail = BlockDetail();

  @override
  void initState() {
    detail = widget.detail;
    detail.name = widget.blockName ?? "";
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
              "Form Kios Blok ${detail.name} No ${detail.number?.name}",
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
                      initialValue: (detail.width ?? 0).toString(),
                      validator: ValidForm.emptyValue,
                      onChanged: (val) {
                        double data = 0;
                        if (val == "") {
                          val = "0";
                        }
                        data = double.parse(val);
                        detail.width = data;
                        setState(() {});
                      },
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}')),
                      ],
                      decoration: TextFormDecoration.box(),
                    ),
                  ),
                ),
                Expanded(
                  child: CustomFormField(
                    title: "Panjang Kios",
                    textForm: TextFormField(
                      initialValue: (detail.width ?? 0).toString(),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}')),
                      ],
                      onChanged: (val) {
                        double data = 0;
                        if (val == "") {
                          val = "0";
                        }
                        data = double.parse(val);
                        detail.length = data;
                        setState(() {});
                      },
                      validator: ValidForm.emptyValue,
                      decoration: TextFormDecoration.box(),
                    ),
                  ),
                ),
              ],
            ),
            CustomFormField(
              title: "Harga",
              textForm: TextFormField(
                initialValue: (detail.width ?? 0).toString(),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
                onChanged: (val) {
                  double data = 0;
                  if (val == "") {
                    val = "0";
                  }
                  data = double.parse(val);
                  detail.price = data;
                  setState(() {});
                },
                validator: ValidForm.emptyValue,
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
                  : detail.picture != null
                      ? (detail.isBase64 == true)
                          ? ClipPicture(
                              height: 40,
                              onTap: () => pickPicture(),
                              child: Image.memory(
                                base64Decode(detail.picture!),
                                fit: BoxFit.fill,
                              ),
                            )
                          : ClipPicture(
                              height: 40,
                              onTap: () => pickPicture(),
                              child: Image.network(
                                detail.picture!,
                                fit: BoxFit.cover,
                              ),
                            )
                      : EmptyImageScreen(onTap: () => pickPicture()),
            ),
            CustomButton(
              title: const Text("Simpan"),
              icon: const Icon(Icons.save_outlined),
              onPressed: () {
                detail.wide = (detail.length ?? 0) * (detail.width ?? 0);
                detail.name =
                    "Block ${widget.blockName} No. ${detail.number?.name}";
                detail.picture = kiosPicture;
                widget.onPress == null ? null : widget.onPress!(detail);
              },
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
      detail.isBase64 = true;
      setState(() {});
    } else {
      // ignore: avoid_print
      print("err");
    }
  }
}
