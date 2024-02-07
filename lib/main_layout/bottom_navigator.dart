import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:fl_pbi/library/library_file.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class BottomNavigation extends StatefulWidget {
  final Widget child;
  const BottomNavigation({super.key, required this.child});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        backgroundColor: AppTheme.nearlyDarkRed,
        onTap: (i) {
          _currentIndex = i;
          callPage(_currentIndex);
          setState(() {});
        },
        items: [
          const CurvedNavigationBarItem(
            child: Icon(
              FontAwesomeIcons.dollarSign,
              color: AppTheme.nearlyDarkRed,
            ),
            label: 'Keuangan',
          ),
          const CurvedNavigationBarItem(
            child: Icon(
              FontAwesomeIcons.person,
              color: AppTheme.nearlyDarkRed,
            ),
            label: 'Customer',
          ),
          CurvedNavigationBarItem(
            child: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Common.imageLogo),
                  scale: 2,
                ),
              ),
            ),
            label: 'Surat Resmi',
          ),
          const CurvedNavigationBarItem(
            child: Icon(
              FontAwesomeIcons.building,
              color: AppTheme.nearlyDarkRed,
            ),
            label: 'Blok',
          ),
          const CurvedNavigationBarItem(
            child: Icon(
              FontAwesomeIcons.user,
              color: AppTheme.nearlyDarkRed,
            ),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  callPage(int index) {
    switch (index) {
      case 0:
        context.go("/finance");
      case 1:
        context.go("/customer");
      case 2:
        context.go("/surat-resmi");
      case 3:
        context.go("/block");
      case 4:
        context.go("/profile");
      default:
        context.go("/surat-resmi");
    }
  }

  dialogAlert() async {
    bool isClose = false;
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            ElevatedButton(
              onPressed: () {
                isClose = false;
                setState(() {});
              },
              child: const Text("No"),
            ),
            ElevatedButton(
              onPressed: () {
                isClose = false;
                setState(() {});
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    ).then((value) => isClose);
  }
}
