import 'dart:convert';
import 'package:fl_pbi/widget/widget_file.dart';
import 'package:flutter/material.dart';

import '../library/common.dart';

class ImageCamera extends StatefulWidget {
  final String? base64;
  final String? data;
  final Function(String) onTap;
  const ImageCamera({super.key, this.base64, this.data, required this.onTap});

  @override
  State<ImageCamera> createState() => _ImageCameraState();
}

class _ImageCameraState extends State<ImageCamera> {
  late String? base64;
  late String? dataImage;
  @override
  void initState() {
    base64 = widget.base64;
    dataImage = widget.data;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomFormField(
      title: "Lampiran",
      textForm: base64 != null
          ? ClipPicture(
              height: 40,
              onTap: () async {
                base64 = await Common.pickPicture(SOURCE.camera);
                widget.onTap(base64!);
                setState(() {});
              },
              child: Image.memory(
                base64Decode(base64!),
                fit: BoxFit.fill,
              ),
            )
          : dataImage != null
              ? ClipPicture(
                  height: 40,
                  onTap: () async {
                    base64 = await Common.pickPicture(SOURCE.camera);
                    widget.onTap(base64!);
                    setState(() {});
                  },
                  child: Image.network(
                    dataImage!,
                    fit: BoxFit.cover,
                  ),
                )
              : EmptyImageScreen(
                  onTap: () async {
                    base64 = await Common.pickPicture(SOURCE.camera);
                    widget.onTap(base64!);
                    setState(() {});
                  },
                ),
    );
  }
}
