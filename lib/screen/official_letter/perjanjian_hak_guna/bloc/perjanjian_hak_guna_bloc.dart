import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:fl_pbi/injector/injector.dart';
import 'package:fl_pbi/injector/navigation_service.dart';
import 'package:fl_pbi/library/session_manager.dart';
import 'package:fl_pbi/models/customer.dart';
import 'package:fl_pbi/models/hak_guna.dart';
import 'package:fl_pbi/models/kios.dart';
import 'package:fl_pbi/models/pic.dart';
import 'package:fl_pbi/screen/profile/data/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jiffy/jiffy.dart';

part 'perjanjian_hak_guna_event.dart';
part 'perjanjian_hak_guna_state.dart';

NavigationService _nav = locator<NavigationService>();

class PerjanjianHakGunaBloc
    extends Bloc<PerjanjianHakGunaEvent, PerjanjianHakGunaState> {
  PerjanjianHakGunaBloc() : super(const PerjanjianHakGunaState()) {
    on<OnChangedNoSurat>(_onChangedNoSurat);
    on<OnChangedSignPlace>(_onChangedSignPlace);
    on<OnChangedDate>(_onChangedDate);
    on<OnChangedNamePihakPertama>(_onChangedNamePihakPertama);
    on<OnChangedDOBPihakPertama>(_onChangedDOBPihakPertama);
    on<OnChangedNikPihakPertama>(_onChangedNikPihakPertama);
    on<OnChangedPhonePihakPertama>(_onChangedPhonePihakPertama);
    on<OnChangedPosition>(_onChangedPosition);
    on<OnChangedAddressPihakPertama>(_onChangedAddressPihakPertama);
    on<OnChangedNamePihakKedua>(_onChangedNamePihakKedua);
    on<OnChangedNikPihakKedua>(_onChangedNikPihakKedua);
    on<OnChangedPhonePihakKedua>(_onChangedPhonePihakKedua);
    on<OnChangedJobPihakKedua>(_onChangedJobPihakKedua);
    on<OnChangedAddressPihakKedua>(_onChangedAddressPihakKedua);
    on<OnChangedLokasiKios>(_onChangedLokasiKios);
    on<OnChangedBlokKios>(_onChangedBlokKios);
    on<OnChangedNoKios>(_onChangedNoKios);
    on<OnChangedJumlahKios>(_onChangedJumlahKios);
    on<OnChangedLuasKios>(_onChangedLuasKios);
    on<OnChangedJangkaWaktu>(_onChangedJangkaWaktu);
    on<OnChangedTandaHakGuna>(_onChangedTandaHakGuna);
    on<OnChangedMulaiHakGuna>(_onChangedMulaiHakGuna);
    on<OnChangedMasaBerlaku>(_onChangedMasaBerlaku);
    on<OnChangedSewaBulanan>(_onChangedSewaBulanan);
    on<OnChangedTagihanListrik>(_onChangedTagihanListrik);
    on<OnInit>(_onInit);
    on<OnSubmit>(_onSubmit);
    on<OnSubmitTemplate>(_onSubmitTemplate);
  }

  BuildContext context = _nav.navKey.currentContext!;
  void _onChangedNoSurat(
      OnChangedNoSurat event, Emitter<PerjanjianHakGunaState> emit) {
    HakGuna? hakGuna = state.hakGuna;
    hakGuna?.no = event.val;
    emit(state.copyWith(hakGuna: hakGuna));
  }

  void _onChangedSignPlace(
      OnChangedSignPlace event, Emitter<PerjanjianHakGunaState> emit) {
    HakGuna? hakGuna = state.hakGuna;
    hakGuna?.createdPlace = event.val;
    emit(state.copyWith(hakGuna: hakGuna));
  }

  void _onChangedDate(
      OnChangedDate event, Emitter<PerjanjianHakGunaState> emit) {
    HakGuna? hakGuna = state.hakGuna;
    if (event.val != null) {
      hakGuna?.createdAt =
          Jiffy.parseFromDateTime(event.val!).format(pattern: "yyyy-MM-dd");
    } else {
      hakGuna?.createdAt = null;
    }
    emit(state.copyWith(hakGuna: hakGuna));
  }

  void _onChangedNamePihakPertama(
      OnChangedNamePihakPertama event, Emitter<PerjanjianHakGunaState> emit) {
    HakGuna? hakGuna = state.hakGuna;
    Pic pic = hakGuna?.pic ?? Pic();
    pic.name = event.val;
    hakGuna?.pic = pic;
    emit(state.copyWith(hakGuna: hakGuna));
  }

  void _onChangedNikPihakPertama(
      OnChangedNikPihakPertama event, Emitter<PerjanjianHakGunaState> emit) {
    HakGuna? hakGuna = state.hakGuna;
    Pic pic = hakGuna?.pic ?? Pic();
    pic.nik = event.val;
    hakGuna?.pic = pic;
    emit(state.copyWith(hakGuna: hakGuna));
  }

  void _onChangedPhonePihakPertama(
      OnChangedPhonePihakPertama event, Emitter<PerjanjianHakGunaState> emit) {
    HakGuna? hakGuna = state.hakGuna;
    Pic pic = hakGuna?.pic ?? Pic();
    pic.phone = event.val;
    hakGuna?.pic = pic;
    emit(state.copyWith(hakGuna: hakGuna));
  }

  void _onChangedPosition(
      OnChangedPosition event, Emitter<PerjanjianHakGunaState> emit) {
    HakGuna? hakGuna = state.hakGuna;
    Pic pic = hakGuna?.pic ?? Pic();
    pic.job = event.val;
    hakGuna?.pic = pic;
    emit(state.copyWith(hakGuna: hakGuna));
  }

  void _onChangedAddressPihakPertama(OnChangedAddressPihakPertama event,
      Emitter<PerjanjianHakGunaState> emit) {
    HakGuna? hakGuna = state.hakGuna;
    Pic pic = hakGuna?.pic ?? Pic();
    pic.address = event.val;
    hakGuna?.pic = pic;
    emit(state.copyWith(hakGuna: hakGuna));
  }

  void _onChangedDOBPihakPertama(
      OnChangedDOBPihakPertama event, Emitter<PerjanjianHakGunaState> emit) {
    HakGuna? hakGuna = state.hakGuna;
    Pic pic = hakGuna?.pic ?? Pic();
    if (event.val != null) {
      pic.dateBirth =
          Jiffy.parseFromDateTime(event.val!).format(pattern: "yyyy-MM-dd");
    } else {
      pic.dateBirth = null;
    }
    hakGuna?.pic = pic;
    emit(state.copyWith(hakGuna: hakGuna));
  }

  void _onChangedNamePihakKedua(
      OnChangedNamePihakKedua event, Emitter<PerjanjianHakGunaState> emit) {
    HakGuna? hakGuna = state.hakGuna;
    Customer customer = hakGuna?.customer ?? Customer();
    customer.name = event.val;
    hakGuna?.customer = customer;
    emit(state.copyWith(hakGuna: hakGuna));
  }

  void _onChangedNikPihakKedua(
      OnChangedNikPihakKedua event, Emitter<PerjanjianHakGunaState> emit) {
    HakGuna? hakGuna = state.hakGuna;
    Customer customer = hakGuna?.customer ?? Customer();
    customer.nik = event.val;
    hakGuna?.customer = customer;
    emit(state.copyWith(hakGuna: hakGuna));
  }

  void _onChangedPhonePihakKedua(
      OnChangedPhonePihakKedua event, Emitter<PerjanjianHakGunaState> emit) {
    HakGuna? hakGuna = state.hakGuna;
    Customer customer = hakGuna?.customer ?? Customer();
    customer.phone = event.val;
    hakGuna?.customer = customer;
    emit(state.copyWith(hakGuna: hakGuna));
  }

  void _onChangedJobPihakKedua(
      OnChangedJobPihakKedua event, Emitter<PerjanjianHakGunaState> emit) {
    HakGuna? hakGuna = state.hakGuna;
    Customer customer = hakGuna?.customer ?? Customer();
    customer.job = event.val;
    hakGuna?.customer = customer;
    emit(state.copyWith(hakGuna: hakGuna));
  }

  void _onChangedAddressPihakKedua(
      OnChangedAddressPihakKedua event, Emitter<PerjanjianHakGunaState> emit) {
    HakGuna? hakGuna = state.hakGuna;
    Customer customer = hakGuna?.customer ?? Customer();
    customer.address = event.val;
    hakGuna?.customer = customer;
    emit(state.copyWith(hakGuna: hakGuna));
  }

  void _onChangedLokasiKios(
      OnChangedLokasiKios event, Emitter<PerjanjianHakGunaState> emit) {
    HakGuna? hakGuna = state.hakGuna;
    Kios kios = hakGuna?.kios ?? Kios();
    kios.location = event.val;
    hakGuna?.kios = kios;
    emit(state.copyWith(hakGuna: hakGuna));
  }

  void _onChangedBlokKios(
      OnChangedBlokKios event, Emitter<PerjanjianHakGunaState> emit) {
    HakGuna? hakGuna = state.hakGuna;
    Kios kios = hakGuna?.kios ?? Kios();
    kios.block = event.val;
    hakGuna?.kios = kios;
    emit(state.copyWith(hakGuna: hakGuna));
  }

  void _onChangedNoKios(
      OnChangedNoKios event, Emitter<PerjanjianHakGunaState> emit) {
    HakGuna? hakGuna = state.hakGuna;
    Kios kios = hakGuna?.kios ?? Kios();
    kios.blockNo = event.val;
    hakGuna?.kios = kios;
    emit(state.copyWith(hakGuna: hakGuna));
  }

  void _onChangedJumlahKios(
      OnChangedJumlahKios event, Emitter<PerjanjianHakGunaState> emit) {
    HakGuna? hakGuna = state.hakGuna;
    Kios kios = hakGuna?.kios ?? Kios();
    kios.totalKios = event.val;
    hakGuna?.kios = kios;
    emit(state.copyWith(hakGuna: hakGuna));
  }

  void _onChangedLuasKios(
      OnChangedLuasKios event, Emitter<PerjanjianHakGunaState> emit) {
    HakGuna? hakGuna = state.hakGuna;
    Kios kios = hakGuna?.kios ?? Kios();
    kios.kiosWide = event.val;
    hakGuna?.kios = kios;
    emit(state.copyWith(hakGuna: hakGuna));
  }

  void _onChangedJangkaWaktu(
      OnChangedJangkaWaktu event, Emitter<PerjanjianHakGunaState> emit) {
    HakGuna? hakGuna = state.hakGuna;
    Kios kios = hakGuna?.kios ?? Kios();
    kios.periodeRent = event.val;
    hakGuna?.kios = kios;
    emit(state.copyWith(hakGuna: hakGuna));
  }

  void _onChangedTandaHakGuna(
      OnChangedTandaHakGuna event, Emitter<PerjanjianHakGunaState> emit) {
    HakGuna? hakGuna = state.hakGuna;
    Kios kios = hakGuna?.kios ?? Kios();
    kios.signHakGuna = event.val;
    hakGuna?.kios = kios;
    emit(state.copyWith(hakGuna: hakGuna));
  }

  void _onChangedSewaBulanan(
      OnChangedSewaBulanan event, Emitter<PerjanjianHakGunaState> emit) {
    HakGuna? hakGuna = state.hakGuna;
    Kios kios = hakGuna?.kios ?? Kios();
    kios.monthCost = event.val;
    hakGuna?.kios = kios;
    emit(state.copyWith(hakGuna: hakGuna));
  }

  void _onChangedTagihanListrik(
      OnChangedTagihanListrik event, Emitter<PerjanjianHakGunaState> emit) {
    HakGuna? hakGuna = state.hakGuna;
    Kios kios = hakGuna?.kios ?? Kios();
    kios.electricCost = event.val;
    hakGuna?.kios = kios;
    emit(state.copyWith(hakGuna: hakGuna));
  }

  void _onChangedMasaBerlaku(
      OnChangedMasaBerlaku event, Emitter<PerjanjianHakGunaState> emit) {
    HakGuna? hakGuna = state.hakGuna;
    Kios kios = hakGuna?.kios ?? Kios();
    if (event.val != null) {
      kios.endDate =
          Jiffy.parseFromDateTime(event.val!).format(pattern: "yyyy-MM-dd");
    } else {
      kios.endDate = null;
    }
    hakGuna?.kios = kios;
    emit(state.copyWith(hakGuna: hakGuna));
  }

  void _onChangedMulaiHakGuna(
      OnChangedMulaiHakGuna event, Emitter<PerjanjianHakGunaState> emit) {
    HakGuna? hakGuna = state.hakGuna;
    Kios kios = hakGuna?.kios ?? Kios();
    if (event.val != null) {
      kios.startDate =
          Jiffy.parseFromDateTime(event.val!).format(pattern: "yyyy-MM-dd");
    } else {
      kios.startDate = null;
    }
    hakGuna?.kios = kios;
    emit(state.copyWith(hakGuna: hakGuna));
  }

  void _onInit(OnInit event, Emitter<PerjanjianHakGunaState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      String? strProfile = await Session.get('profile');
      Profile profile = await getProfileSession(strProfile ?? "{}");
      HakGuna? hakGuna = await getHakGuna(profile);
      // Future.delayed(const Duration(seconds: 3));
      emit(state.copyWith(hakGuna: hakGuna, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  void _onSubmit(OnSubmit event, Emitter<PerjanjianHakGunaState> emit) async {
    try {
      HakGuna? hakGuna = state.hakGuna;
      _nav.navKey.currentContext!.pushNamed("preview-pdf", extra: {
        "data": hakGuna,
        "pdf": hakGuna!.perjanjianPdf(),
        "title":
            "Surat Perjanjian Hak Guna ${DateTime.now().millisecond.toString()}"
      });
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  void _onSubmitTemplate(
      OnSubmitTemplate event, Emitter<PerjanjianHakGunaState> emit) async {
    try {
      _nav.navKey.currentContext!.pushNamed("preview-pdf", extra: {
        "data": HakGuna(),
        "pdf": HakGuna().perjanjianPdf(),
        "title":
            "Surat Perjanjian Hak Guna ${DateTime.now().millisecond.toString()}"
      });
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<Profile> getProfileSession(String strProfile) async {
    // Future.delayed(const Duration(seconds: 1));
    Profile profile = Profile.fromJson(jsonDecode(strProfile));
    return profile;
  }

  Future<HakGuna?> getHakGuna(Profile profile) async {
    // Future.delayed(const Duration(seconds: 2));
    HakGuna hakGuna = HakGuna();
    Pic pic = hakGuna.pic ?? Pic();
    pic.name = profile.fullName;
    pic.address = profile.currentAddress;
    pic.dateBirth = profile.birthDate;
    pic.nik = profile.identity?.idNumber;
    pic.phone = profile.phone;
    hakGuna.pic = pic;
    return hakGuna;
  }
}
