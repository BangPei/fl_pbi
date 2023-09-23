import 'package:fl_pbi/router/go_routers.dart';
import 'package:fl_pbi/screen/login/bloc/login_bloc.dart';
import 'package:fl_pbi/screen/official_letter/formulir_pendaftaran/bloc/formulir_pendaftaran_bloc.dart';
import 'package:fl_pbi/screen/official_letter/surat_lunas/bloc/surat_lunas_bloc.dart';
import 'package:fl_pbi/screen/official_letter/surat_permohonan/bloc/permohonan_bloc.dart';
import 'package:fl_pbi/screen/official_letter/surat_sewa_lahan/bloc/sewa_lahan_bloc.dart';
import 'package:fl_pbi/screen/profile/bloc/profile_form_bloc.dart';
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
        BlocProvider<FormulirPendaftaranBloc>(
            create: (__) => FormulirPendaftaranBloc()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: RouteNavigation.router,
      ),
    );
  }
}
