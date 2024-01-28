import 'package:equatable/equatable.dart';
import 'package:fl_pbi/injector/inject_file.dart';
import 'package:fl_pbi/pages/official_letter_form/surat_sewa_lahan/sewa_lahan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jiffy/jiffy.dart';

import '../../../../library/library_file.dart';

part 'sewa_lahan_event.dart';
part 'sewa_lahan_state.dart';

NavigationService _nav = locator<NavigationService>();

class SewaLahanBloc extends Bloc<SewaLahanEvent, SewaLahanState> {
  SewaLahanBloc() : super(const SewaLahanState()) {
    on<OnSubmit>(_onSubmit);
    on<OnSubmitTemplate>(_onSubmitTemplate);
    on<OnChangedPihakPertama>(_onChangedPihakPertama);
    on<OnChangedPihakKedua>(_onChangedPihakKedua);
    on<OnChangedNik>(_onChangedNik);
    on<OnChangedPhone>(_onChangedPhone);
    on<OnChangedAddress>(_onChangedAddress);
    on<OnChangedAreaLahan>(_onChangedAreaLahan);
    on<OnChangedPemilikArea>(_onChangedPemilikArea);
    on<OnChangedLuasArea>(_onChangedLuasArea);
    on<OnChangedDurasiSewa>(_onChangedDurasiSewa);
    on<OnChangedDurasiPerpanjangan>(_onChangedDurasiPerpanjangan);
    on<OnChangedTanggalPerjanjian>(_onChangedTanggalPerjanjian);
    on<OnChangedPeriodeSewaLahan>(_onChangedPeriodeSewaLahan);
  }
  BuildContext context = _nav.navKey.currentContext!;
  void _onChangedTanggalPerjanjian(
      OnChangedTanggalPerjanjian event, Emitter<SewaLahanState> emit) {
    SuratSewaLahan? sewaLahan = state.sewaLahan ?? SuratSewaLahan();
    sewaLahan.date =
        Jiffy.parseFromDateTime(event.val!).format(pattern: "yyyy-MM-dd");
    // if (event.val != null) {
    //   if ((sewaLahan.periodeRent != null) || (sewaLahan.periodeRent ?? 0) > 0) {
    //     var newDate = Jiffy.parseFromDateTime(event.val!)
    //         .add(years: sewaLahan.periodeRent!)
    //         .format(pattern: 'yyyy-MM-dd');
    //     sewaLahan.periodeDate = newDate;
    //   }
    // } else {
    //   sewaLahan.date = null;
    //   sewaLahan.periodeDate = null;
    // }
    emit(state.copyWith(sewaLahan: sewaLahan));
  }

  void _onChangedPeriodeSewaLahan(
      OnChangedPeriodeSewaLahan event, Emitter<SewaLahanState> emit) {
    SuratSewaLahan? sewaLahan = state.sewaLahan ?? SuratSewaLahan();
    sewaLahan.periodeDate =
        Jiffy.parseFromDateTime(event.val!).format(pattern: "yyyy-MM-dd");
    emit(state.copyWith(sewaLahan: sewaLahan));
  }

  void _onChangedDurasiPerpanjangan(
      OnChangedDurasiPerpanjangan event, Emitter<SewaLahanState> emit) {
    SuratSewaLahan? sewaLahan = state.sewaLahan ?? SuratSewaLahan();
    sewaLahan.extraTime = event.val;
    emit(state.copyWith(sewaLahan: sewaLahan));
  }

  void _onChangedDurasiSewa(
      OnChangedDurasiSewa event, Emitter<SewaLahanState> emit) {
    SuratSewaLahan? sewaLahan = state.sewaLahan ?? SuratSewaLahan();
    sewaLahan.periodeRent = event.val;
    // if ((sewaLahan.date != null)) {
    //   var newDate = Jiffy.parse(sewaLahan.date!)
    //       .add(years: event.val)
    //       .format(pattern: 'yyyy-MM-dd');
    //   sewaLahan.periodeDate = newDate;
    // } else {
    //   sewaLahan.periodeDate = null;
    // }
    emit(state.copyWith(sewaLahan: sewaLahan));
  }

  void _onChangedLuasArea(
      OnChangedLuasArea event, Emitter<SewaLahanState> emit) {
    SuratSewaLahan? sewaLahan = state.sewaLahan ?? SuratSewaLahan();
    sewaLahan.wide = event.val;
    emit(state.copyWith(sewaLahan: sewaLahan));
  }

  void _onChangedPemilikArea(
      OnChangedPemilikArea event, Emitter<SewaLahanState> emit) {
    SuratSewaLahan? sewaLahan = state.sewaLahan ?? SuratSewaLahan();
    sewaLahan.areaCompany = event.val;
    emit(state.copyWith(sewaLahan: sewaLahan));
  }

  void _onChangedAreaLahan(
      OnChangedAreaLahan event, Emitter<SewaLahanState> emit) {
    SuratSewaLahan? sewaLahan = state.sewaLahan ?? SuratSewaLahan();
    sewaLahan.areaName = event.val;
    emit(state.copyWith(sewaLahan: sewaLahan));
  }

  void _onChangedAddress(OnChangedAddress event, Emitter<SewaLahanState> emit) {
    SuratSewaLahan? sewaLahan = state.sewaLahan ?? SuratSewaLahan();
    sewaLahan.address = event.val;
    emit(state.copyWith(sewaLahan: sewaLahan));
  }

  void _onChangedPhone(OnChangedPhone event, Emitter<SewaLahanState> emit) {
    SuratSewaLahan? sewaLahan = state.sewaLahan ?? SuratSewaLahan();
    sewaLahan.phone = event.val;
    emit(state.copyWith(sewaLahan: sewaLahan));
  }

  void _onChangedNik(OnChangedNik event, Emitter<SewaLahanState> emit) {
    SuratSewaLahan? sewaLahan = state.sewaLahan ?? SuratSewaLahan();
    sewaLahan.nik = event.val;
    emit(state.copyWith(sewaLahan: sewaLahan));
  }

  void _onChangedPihakKedua(
      OnChangedPihakKedua event, Emitter<SewaLahanState> emit) {
    SuratSewaLahan? sewaLahan = state.sewaLahan ?? SuratSewaLahan();
    sewaLahan.name = event.val;
    emit(state.copyWith(sewaLahan: sewaLahan));
  }

  void _onChangedPihakPertama(
      OnChangedPihakPertama event, Emitter<SewaLahanState> emit) {
    SuratSewaLahan? sewaLahan = state.sewaLahan ?? SuratSewaLahan();
    sewaLahan.ownerName = event.val;
    emit(state.copyWith(sewaLahan: sewaLahan));
  }

  void _onSubmit(OnSubmit event, Emitter<SewaLahanState> emit) async {
    SuratSewaLahan? sewaLahan = state.sewaLahan ?? SuratSewaLahan();
    sewaLahan.areaCompany = sewaLahan.areaCompany ?? areaCompany;
    sewaLahan.ownerName = sewaLahan.ownerName ?? ownerName;
    context.pushNamed("preview-pdf", extra: {
      "data": sewaLahan,
      "pdf": sewaLahan.pdf(),
      "title": "Surat Permohonan ${DateTime.now().millisecond.toString()}"
    });
  }

  void _onSubmitTemplate(
      OnSubmitTemplate event, Emitter<SewaLahanState> emit) async {
    context.pushNamed("preview-pdf", extra: {
      "data": SuratSewaLahan(),
      "pdf": SuratSewaLahan().pdf(),
      "title": "Surat Permohonan ${DateTime.now().millisecond.toString()}"
    });
  }
}
