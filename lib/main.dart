import 'package:fl_pbi/service/go_routers.dart';
import 'package:fl_pbi/service/injector.dart';
import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:jiffy/jiffy.dart';

void main() async {
  setPathUrlStrategy();
  setupLocator();
  await Jiffy.setLocale('id');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: RouteNavigation.router,
    );
  }
}
