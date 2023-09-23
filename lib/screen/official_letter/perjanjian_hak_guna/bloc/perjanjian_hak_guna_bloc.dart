import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'perjanjian_hak_guna_event.dart';
part 'perjanjian_hak_guna_state.dart';

class PerjanjianHakGunaBloc
    extends Bloc<PerjanjianHakGunaEvent, PerjanjianHakGunaState> {
  PerjanjianHakGunaBloc() : super(PerjanjianHakGunaInitial()) {
    on<PerjanjianHakGunaEvent>((event, emit) {});
  }
}
