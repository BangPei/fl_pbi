import 'package:equatable/equatable.dart';
import 'package:fl_pbi/screen/profile/data/profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

part 'surat_lunas_event.dart';
part 'surat_lunas_state.dart';

class SuratLunasBloc extends Bloc<SuratLunasEvent, SuratLunasState> {
  SuratLunasBloc() : super(SuratLunasState()) {
    on<SuratLunasEvent>((event, emit) {});
  }
}
