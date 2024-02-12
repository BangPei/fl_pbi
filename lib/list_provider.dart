import 'package:fl_pbi/pages/block/bloc/block_bloc.dart';
import 'package:fl_pbi/pages/block/bloc/block_form_bloc.dart';
import 'package:fl_pbi/pages/company/bloc/company_bloc.dart';
import 'package:fl_pbi/pages/customer/bloc/customer_bloc.dart';
import 'package:fl_pbi/pages/customer/bloc/form_customer_bloc.dart';
import 'package:fl_pbi/pages/finance/bloc/finanace_bloc.dart';
import 'package:fl_pbi/pages/ipl/bloc/form_ipl_bloc.dart';
import 'package:fl_pbi/pages/ipl/bloc/ipl_bloc.dart';
import 'package:fl_pbi/pages/login/bloc/login_bloc.dart';
import 'package:fl_pbi/pages/official_letter_form/formulir_pendaftaran/bloc/formulir_pendaftaran_bloc.dart';
import 'package:fl_pbi/pages/official_letter_form/perjanjian_hak_guna/bloc/perjanjian_hak_guna_bloc.dart';
import 'package:fl_pbi/pages/official_letter_form/serah_terima_kunci/bloc/serah_terima_kunci_bloc.dart';
import 'package:fl_pbi/pages/official_letter_form/surat_lunas/bloc/surat_lunas_bloc.dart';
import 'package:fl_pbi/pages/official_letter_form/surat_permohonan/bloc/permohonan_bloc.dart';
import 'package:fl_pbi/pages/official_letter_form/surat_sewa_lahan/bloc/sewa_lahan_bloc.dart';
import 'package:fl_pbi/pages/official_letter_form/tanda_hak_guna/bloc/tanda_hak_guna_bloc.dart';
import 'package:fl_pbi/pages/parking/bloc/park_bloc.dart';
import 'package:fl_pbi/pages/parking/bloc/park_form_bloc.dart';
import 'package:fl_pbi/pages/profile/bloc/number_bloc.dart';
import 'package:fl_pbi/pages/profile/bloc/profile_form_bloc.dart';
import 'package:fl_pbi/pages/report/bloc/report_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProviderBloc {
  ProviderBloc._();
  List<BlocProvider>? provider;

  static List<BlocProvider> get() {
    return [
      BlocProvider<LoginBloc>(create: (__) => LoginBloc()),
      BlocProvider<ProfileFormBloc>(create: (__) => ProfileFormBloc()),
      BlocProvider<PermohonanBloc>(create: (__) => PermohonanBloc()),
      BlocProvider<SuratLunasBloc>(create: (__) => SuratLunasBloc()),
      BlocProvider<SewaLahanBloc>(create: (__) => SewaLahanBloc()),
      BlocProvider<IplBloc>(create: (__) => IplBloc()),
      BlocProvider<FormIplBloc>(create: (__) => FormIplBloc()),
      BlocProvider<ParkingBloc>(create: (__) => ParkingBloc()),
      BlocProvider<ParkFormBloc>(create: (__) => ParkFormBloc()),
      BlocProvider<NumberBloc>(create: (__) => NumberBloc()),
      BlocProvider<BlockBloc>(create: (__) => BlockBloc()),
      BlocProvider<FinanceBloc>(create: (__) => FinanceBloc()),
      BlocProvider<BlockFormBloc>(create: (__) => BlockFormBloc()),
      BlocProvider<ReportBloc>(create: (__) => ReportBloc()),
      BlocProvider<CustomerBloc>(create: (__) => CustomerBloc()),
      BlocProvider<FormCustomerBloc>(create: (__) => FormCustomerBloc()),
      BlocProvider<CompanyBloc>(create: (__) => CompanyBloc()),
      BlocProvider<SerahTerimaKunciBloc>(
          create: (__) => SerahTerimaKunciBloc()),
      BlocProvider<TandaHakGunaBloc>(create: (__) => TandaHakGunaBloc()),
      BlocProvider<PerjanjianHakGunaBloc>(
          create: (__) => PerjanjianHakGunaBloc()),
      BlocProvider<FormulirPendaftaranBloc>(
          create: (__) => FormulirPendaftaranBloc()),
    ];
  }
}
