import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:fl_pbi/injector/injector.dart';
import 'package:fl_pbi/injector/navigation_service.dart';
import 'package:fl_pbi/library/session_manager.dart';
import 'package:fl_pbi/pages/official_letter_form/surat_lunas/lunas.dart';
import 'package:fl_pbi/pages/profile/data/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jiffy/jiffy.dart';

part 'surat_lunas_event.dart';
part 'surat_lunas_state.dart';

NavigationService _nav = locator<NavigationService>();

class SuratLunasBloc extends Bloc<SuratLunasEvent, SuratLunasState> {
  SuratLunasBloc() : super(const SuratLunasState()) {
    on<OnNameChanged>(_onNameChanged);
    on<OnNikChanged>(_onNikChanged);
    on<OnPositionChanged>(_onPositionChanged);
    on<OnPhoneChanged>(_onPhoneChanged);
    on<OnAddressChanged>(_onAddressChanged);
    on<OnBlockChanged>(_onBlockChanged);
    on<OnDateChanged>(_onDateChanged);
    on<OnInitLunas>(_onInitLunas);
    on<OnSubmit>(_onSubmit);
    on<OnSubmitTemplate>(_onSubmitTemplate);
  }
  BuildContext context = _nav.navKey.currentContext!;
  void _onNameChanged(OnNameChanged event, Emitter<SuratLunasState> emit) {
    SuratLunas? lunas = state.lunas;
    lunas?.name = event.val;
    emit(state.copyWith(lunas: lunas));
  }

  void _onNikChanged(OnNikChanged event, Emitter<SuratLunasState> emit) {
    SuratLunas? lunas = state.lunas;
    lunas?.nik = event.val;
    emit(state.copyWith(lunas: lunas));
  }

  void _onPositionChanged(
      OnPositionChanged event, Emitter<SuratLunasState> emit) {
    SuratLunas? lunas = state.lunas;
    lunas?.position = event.val;
    emit(state.copyWith(lunas: lunas));
  }

  void _onPhoneChanged(OnPhoneChanged event, Emitter<SuratLunasState> emit) {
    SuratLunas? lunas = state.lunas;
    lunas?.phone = event.val;
    emit(state.copyWith(lunas: lunas));
  }

  void _onAddressChanged(
      OnAddressChanged event, Emitter<SuratLunasState> emit) {
    SuratLunas? lunas = state.lunas;
    lunas?.address = event.val;
    emit(state.copyWith(lunas: lunas));
  }

  void _onBlockChanged(OnBlockChanged event, Emitter<SuratLunasState> emit) {
    SuratLunas? lunas = state.lunas;
    lunas?.block = event.val;
    emit(state.copyWith(lunas: lunas));
  }

  void _onDateChanged(OnDateChanged event, Emitter<SuratLunasState> emit) {
    SuratLunas? lunas = state.lunas;
    if (event.val != null) {
      lunas?.date =
          Jiffy.parseFromDateTime(event.val!).format(pattern: "yyyy-MM-dd");
    } else {
      lunas?.date = null;
    }
    emit(state.copyWith(lunas: lunas));
  }

  void _onInitLunas(OnInitLunas event, Emitter<SuratLunasState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      String? strProfile = await Session.get('profile');
      Profile profile = await getProfileSession(strProfile ?? "{}");
      SuratLunas? lunas = await getLunas(profile);
      emit(state.copyWith(lunas: lunas, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  void _onSubmit(OnSubmit event, Emitter<SuratLunasState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      SuratLunas? lunas = state.lunas ?? SuratLunas();
      _nav.navKey.currentContext!.pushNamed("preview-pdf", extra: {
        "data": lunas,
        "pdf": lunas.pdf(),
        "title":
            "Surat Keterangan Lunas ${DateTime.now().millisecond.toString()}"
      });
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  void _onSubmitTemplate(
      OnSubmitTemplate event, Emitter<SuratLunasState> emit) async {
    try {
      _nav.navKey.currentContext!.pushNamed("preview-pdf", extra: {
        "data": SuratLunas(),
        "pdf": SuratLunas().pdf(),
        "title":
            "Surat Keterangan Lunas ${DateTime.now().millisecond.toString()}"
      });
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<Profile> getProfileSession(String strProfile) async {
    Profile profile = Profile.fromJson(jsonDecode(strProfile));
    return profile;
  }

  Future<SuratLunas?> getLunas(Profile profile) async {
    SuratLunas? lunas = state.lunas;
    lunas?.address = profile.currentAddress;
    lunas?.nik = profile.identity?.idNumber;
    lunas?.name = profile.fullName;
    lunas?.phone = profile.phone;
    return lunas;
  }
}
