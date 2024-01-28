import 'package:fl_pbi/library/library_file.dart';
import 'package:fl_pbi/widget/widget_file.dart';
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
      appBar: CustomAppbar(
        backgroundColor: AppTheme.white,
        leading: Container(
          padding: const EdgeInsets.only(left: 10),
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Image.asset(Common.imageLogo),
        ),
        title: "Dashboard",
      ),
      body: const SingleChildScrollView(),
    );
  }
}
