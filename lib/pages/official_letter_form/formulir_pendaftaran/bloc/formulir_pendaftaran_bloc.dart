import 'package:equatable/equatable.dart';
import 'package:fl_pbi/injector/inject_file.dart';
import 'package:fl_pbi/pages/official_letter_form/formulir_pendaftaran/pendaftaran.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part 'formulir_pendaftaran_event.dart';
part 'formulir_pendaftaran_state.dart';

NavigationService _nav = locator<NavigationService>();

class FormulirPendaftaranBloc
    extends Bloc<FormulirPendaftaranEvent, FormulirPendaftaranState> {
  FormulirPendaftaranBloc() : super(const FormulirPendaftaranState()) {
    on<OnNameChanged>(_onNameChanged);
    on<OnNikChanged>(_onNikChanged);
    on<OnPhoneChanged>(_onPhoneChanged);
    on<OnBlockChanged>(_onBlockChanged);
    on<OnAddressChanged>(_onAddressChanged);
    on<OnPicChanged>(_onPicChanged);
    on<OnSubmit>(_onSubmit);
    on<OnSubmitTemplate>(_onSubmitTemplate);
  }

  BuildContext context = _nav.navKey.currentContext!;

  void _onNameChanged(
      OnNameChanged event, Emitter<FormulirPendaftaranState> emit) {
    Pendaftaran? pendaftaran = state.pendaftaran;
    pendaftaran?.name = event.vals;
    emit(state.copyWith(pendaftaran: pendaftaran));
  }

  void _onNikChanged(
      OnNikChanged event, Emitter<FormulirPendaftaranState> emit) {
    Pendaftaran? pendaftaran = state.pendaftaran;
    pendaftaran?.nik = event.vals;
    emit(state.copyWith(pendaftaran: pendaftaran));
  }

  void _onPhoneChanged(
      OnPhoneChanged event, Emitter<FormulirPendaftaranState> emit) {
    Pendaftaran? pendaftaran = state.pendaftaran;
    pendaftaran?.phone = event.vals;
    emit(state.copyWith(pendaftaran: pendaftaran));
  }

  void _onBlockChanged(
      OnBlockChanged event, Emitter<FormulirPendaftaranState> emit) {
    Pendaftaran? pendaftaran = state.pendaftaran;
    pendaftaran?.block = event.vals;
    emit(state.copyWith(pendaftaran: pendaftaran));
  }

  void _onAddressChanged(
      OnAddressChanged event, Emitter<FormulirPendaftaranState> emit) {
    Pendaftaran? pendaftaran = state.pendaftaran;
    pendaftaran?.address = event.vals;
    emit(state.copyWith(pendaftaran: pendaftaran));
  }

  void _onPicChanged(
      OnPicChanged event, Emitter<FormulirPendaftaranState> emit) {
    Pendaftaran? pendaftaran = state.pendaftaran;
    pendaftaran?.pic = event.vals;
    emit(state.copyWith(pendaftaran: pendaftaran));
  }

  void _onSubmit(OnSubmit event, Emitter<FormulirPendaftaranState> emit) {
    Pendaftaran? pendaftaran = state.pendaftaran ?? Pendaftaran();
    context.pushNamed("preview-pdf", extra: {
      "data": pendaftaran,
      "pdf": pendaftaran.pdf(),
      "title": "Surat Pendaftaran ${DateTime.now().millisecond.toString()}"
    });
  }

  void _onSubmitTemplate(
      OnSubmitTemplate event, Emitter<FormulirPendaftaranState> emit) {
    Pendaftaran pendaftaran = Pendaftaran();
    context.pushNamed("preview-pdf", extra: {
      "data": pendaftaran,
      "pdf": pendaftaran.pdf(),
      "title": "Surat Pendaftaran${DateTime.now().millisecond.toString()}"
    });
  }
}
