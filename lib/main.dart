import 'package:fl_pbi/pages/block/bloc/block_bloc.dart';
import 'package:fl_pbi/pages/parking/bloc/park_bloc.dart';
import 'package:fl_pbi/pages/parking/bloc/park_form_bloc.dart';
import 'package:fl_pbi/pages/profile/bloc/number_bloc.dart';
import 'package:fl_pbi/router/go_routers.dart';
import 'package:fl_pbi/pages/login/bloc/login_bloc.dart';
import 'package:fl_pbi/pages/official_letter_form/formulir_pendaftaran/bloc/formulir_pendaftaran_bloc.dart';
import 'package:fl_pbi/pages/official_letter_form/perjanjian_hak_guna/bloc/perjanjian_hak_guna_bloc.dart';
import 'package:fl_pbi/pages/official_letter_form/surat_lunas/bloc/surat_lunas_bloc.dart';
import 'package:fl_pbi/pages/official_letter_form/surat_permohonan/bloc/permohonan_bloc.dart';
import 'package:fl_pbi/pages/official_letter_form/surat_sewa_lahan/bloc/sewa_lahan_bloc.dart';
import 'package:fl_pbi/pages/official_letter_form/tanda_hak_guna/bloc/tanda_hak_guna_bloc.dart';
import 'package:fl_pbi/pages/profile/bloc/profile_form_bloc.dart';
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
      providers: [
        BlocProvider<LoginBloc>(create: (__) => LoginBloc()),
        BlocProvider<ProfileFormBloc>(create: (__) => ProfileFormBloc()),
        BlocProvider<PermohonanBloc>(create: (__) => PermohonanBloc()),
        BlocProvider<SuratLunasBloc>(create: (__) => SuratLunasBloc()),
        BlocProvider<SewaLahanBloc>(create: (__) => SewaLahanBloc()),
        BlocProvider<ParkingBloc>(create: (__) => ParkingBloc()),
        BlocProvider<ParkFormBloc>(create: (__) => ParkFormBloc()),
        BlocProvider<NumberBloc>(create: (__) => NumberBloc()),
        BlocProvider<BlockBloc>(create: (__) => BlockBloc()),
        BlocProvider<TandaHakGunaBloc>(create: (__) => TandaHakGunaBloc()),
        BlocProvider<PerjanjianHakGunaBloc>(
            create: (__) => PerjanjianHakGunaBloc()),
        BlocProvider<FormulirPendaftaranBloc>(
            create: (__) => FormulirPendaftaranBloc()),
      ],
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
