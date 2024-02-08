import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EmptyImageScreen extends StatelessWidget {
  final GestureTapCallback? onTap;
  final IconData? iconData;
  final double? height;
  final String? title;
  const EmptyImageScreen(
      {super.key, this.onTap, this.iconData, this.height, this.title});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: const Radius.circular(12),
      padding: const EdgeInsets.all(6),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            height: height ?? 150,
            color: const Color.fromARGB(255, 253, 253, 249),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    iconData ?? FontAwesomeIcons.camera,
                    color: Colors.indigo,
                  ),
                  const SizedBox(height: 10),
                  Text(title ?? "Tekan Untuk Mengambil Gambar",
                      style: const TextStyle(
                        color: Colors.indigo,
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
