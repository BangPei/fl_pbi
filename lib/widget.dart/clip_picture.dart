import 'package:flutter/material.dart';

class ClipPicture extends StatelessWidget {
  final Widget child;
  final double? height;
  final GestureTapCallback? onTap;
  const ClipPicture(
      {super.key, required this.child, required this.onTap, this.height});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          child,
          GestureDetector(
            onTap: onTap,
            child: Container(
              height: height ?? 25,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.4)),
              child: const Padding(
                padding: EdgeInsets.all(3.0),
                child: Center(
                  child: Text(
                    "Edit",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
