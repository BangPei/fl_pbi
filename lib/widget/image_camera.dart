import 'dart:convert';
import 'package:fl_pbi/library/library_file.dart';
import 'package:fl_pbi/widget/widget_file.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class ImageCamera extends StatefulWidget {
  final String? title;
  final String? base64;
  final String? data;
  final bool? isOcr;
  final Function(RecognizedText)? ocr;
  final Function(String) onTap;
  const ImageCamera(
      {super.key,
      this.base64,
      this.data,
      required this.onTap,
      this.title,
      this.isOcr,
      this.ocr});

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
      title: widget.title ?? "Lampiran",
      textForm: base64 != null
          ? ClipPicture(
              height: 40,
              onTap: () => takePicture(isOcr: widget.isOcr, ocr: widget.ocr),
              child: Image.memory(
                base64Decode(base64!),
                fit: BoxFit.fill,
              ),
            )
          : dataImage != null
              ? ClipPicture(
                  onTap: () =>
                      takePicture(isOcr: widget.isOcr, ocr: widget.ocr),
                  child: FadeInImage(
                    image: NetworkImage(dataImage!, scale: 1),
                    placeholder: AssetImage(Common.imageLoading),
                    imageErrorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        FontAwesomeIcons.idCard,
                        color: AppTheme.blue,
                        size: 45,
                      );
                    },
                    fit: BoxFit.fitWidth,
                  ),
                )
              : EmptyImageScreen(
                  onTap: () =>
                      takePicture(isOcr: widget.isOcr, ocr: widget.ocr)),
    );
  }

  takePicture({bool? isOcr, Function(RecognizedText)? ocr}) {
    bottomDialog(
      onTap: (source) async {
        base64 = await Common.pickPicture(
          context,
          source,
          isOcr: isOcr,
          onOcr: ocr,
        );
        if (base64 != null) {
          widget.onTap(base64!);
          setState(() {});
        }
      },
    );
  }

  bottomDialog({required Function(SOURCE) onTap}) async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "Pilih Sumber Gambar",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: AppTheme.deactivatedText,
                    ),
                  ),
                  const SizedBox(height: 40),
                  CamerButton(
                    icon: Icons.photo,
                    title: "Galeri",
                    onTap: () {
                      onTap(SOURCE.galery);
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(height: 20),
                  CamerButton(
                    icon: Icons.camera_alt_outlined,
                    title: "Camera",
                    onTap: () {
                      onTap(SOURCE.camera);
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class CamerButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final GestureTapCallback? onTap;
  const CamerButton(
      {super.key, required this.title, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color.fromARGB(255, 214, 206, 206),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 30,
                color: const Color.fromARGB(255, 83, 83, 83),
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  color: Color.fromARGB(255, 83, 83, 83),
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
