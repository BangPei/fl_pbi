import 'package:fl_pbi/library/common.dart';
import 'package:fl_pbi/widget.dart/custom_appbar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final AnimationController? animationController;
  const HomeScreen({super.key, this.animationController});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: CustomAppbar(
          leading: Container(
            padding: const EdgeInsets.only(left: 5),
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Image.asset(Common.imageLogo),
          ),
          title: "Perniagaan Bumi Indah",
        ),
      ),
    );
  }
}
