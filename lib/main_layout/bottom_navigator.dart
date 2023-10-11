import 'package:fl_pbi/library/common.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavigation extends StatefulWidget {
  final Widget child;
  const BottomNavigation({Key? key, required this.child}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        fixedColor: const Color.fromARGB(255, 241, 4, 36),
        onTap: (i) {
          _currentIndex = i;
          callPage(_currentIndex);
          setState(() {});
        },
        items: [
          // BottomNavigationBarItem(
          //   label: "Dashboard",
          //   icon: Image.asset(
          //     Common.imageHome,
          //     width: 30.0,
          //     height: 30.0,
          //     fit: BoxFit.cover,
          //   ),
          // ),
          BottomNavigationBarItem(
            label: "Surat Resmi",
            icon: Image.asset(
              Common.imageLogo,
              width: 30.0,
              height: 30.0,
              fit: BoxFit.cover,
            ),
          ),
          // BottomNavigationBarItem(
          //   label: "Keuangan",
          //   icon: Image.asset(
          //     Common.imageDollar,
          //     width: 30.0,
          //     height: 30.0,
          //     fit: BoxFit.cover,
          //   ),
          // ),
          BottomNavigationBarItem(
            label: "Akun",
            icon: Image.asset(
              Common.imageProfile,
              width: 30.0,
              height: 30.0,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  callPage(int index) {
    switch (index) {
      case 0:
        // context.go("/");
        context.go("/surat-resmi");
      case 1:
        // context.go("/surat-resmi");
        context.go("/profile");
      // case 2:
      //   context.go("/keuangan");
      // case 3:
      //   context.go("/profile");
      default:
        context.go("/surat-resmi");
    }
  }
}
