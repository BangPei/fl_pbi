import 'package:fl_pbi/list_provider.dart';
import 'package:fl_pbi/router/go_routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:jiffy/jiffy.dart';
import 'injector/injector.dart';

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
    return MultiBlocProvider(
      providers: ProviderBloc.get(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: RouteNavigation.router,
        theme: ThemeData(
          fontFamily: 'Lato',
          scaffoldBackgroundColor: const Color.fromARGB(255, 247, 246, 246),
        ),
      ),
    );
  }
}
