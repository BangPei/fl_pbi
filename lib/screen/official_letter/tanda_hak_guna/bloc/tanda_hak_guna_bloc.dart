import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tanda_hak_guna_event.dart';
part 'tanda_hak_guna_state.dart';

class TandaHakGunaBloc extends Bloc<TandaHakGunaEvent, TandaHakGunaState> {
  TandaHakGunaBloc() : super(TandaHakGunaInitial()) {
    on<TandaHakGunaEvent>((event, emit) {});
  }
}
