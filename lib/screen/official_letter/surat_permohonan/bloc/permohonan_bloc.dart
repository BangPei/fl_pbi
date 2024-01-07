import 'package:equatable/equatable.dart';
import 'package:fl_pbi/injector/injector.dart';
import 'package:fl_pbi/injector/navigation_service.dart';
import 'package:fl_pbi/screen/official_letter/surat_permohonan/permohonan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part 'permohonan_event.dart';
part 'permohonan_state.dart';

NavigationService _nav = locator<NavigationService>();

class PermohonanBloc extends Bloc<PermohonanEvent, PermohonanState> {
  PermohonanBloc() : super(const PermohonanState()) {
    on<OnChangedName>(_onChangedName);
    on<OnChangedNik>(_onChangedNik);
    on<OnChangedPhone>(_onChangedPhone);
    on<OnChangedAddress>(_onChangedAddress);
    on<OnSubmit>(_onSubmit);
    on<OnSubmitTemplate>(_onSubmitTemplate);
  }
  BuildContext context = _nav.navKey.currentContext!;
  void _onChangedName(OnChangedName event, Emitter<PermohonanState> emit) {
    SuratPermohonan? permohonan = state.permohonan;
    permohonan?.name = event.val;
    emit(state.copyWith(permohonan: permohonan));
  }

  void _onChangedNik(OnChangedNik event, Emitter<PermohonanState> emit) {
    SuratPermohonan? permohonan = state.permohonan;
    permohonan?.nik = event.val;
    emit(state.copyWith(permohonan: permohonan));
  }

  void _onChangedPhone(OnChangedPhone event, Emitter<PermohonanState> emit) {
    SuratPermohonan? permohonan = state.permohonan;
    permohonan?.phone = event.val;
    emit(state.copyWith(permohonan: permohonan));
  }

  void _onChangedAddress(
      OnChangedAddress event, Emitter<PermohonanState> emit) {
    SuratPermohonan? permohonan = state.permohonan;
    permohonan?.address = event.val;
    emit(state.copyWith(permohonan: permohonan));
  }

  void _onSubmit(OnSubmit event, Emitter<PermohonanState> emit) {
    SuratPermohonan? permohonan = state.permohonan ?? SuratPermohonan();

    context.pushNamed("preview-pdf", extra: {
      "data": permohonan,
      "pdf": permohonan.pdf(),
      "title": "Surat Permohonan ${DateTime.now().millisecond.toString()}"
    });
  }

  void _onSubmitTemplate(
      OnSubmitTemplate event, Emitter<PermohonanState> emit) {
    context.pushNamed("preview-pdf", extra: {
      "data": SuratPermohonan(),
      "pdf": SuratPermohonan().pdf(),
      "title": "Surat Permohonan ${DateTime.now().millisecond.toString()}"
    });
  }
}
