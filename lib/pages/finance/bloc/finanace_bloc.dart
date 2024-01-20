import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'finanace_event.dart';
part 'finanace_state.dart';

class FinanaceBloc extends Bloc<FinanaceEvent, FinanaceState> {
  FinanaceBloc() : super(FinanaceInitial()) {
    on<FinanaceEvent>((event, emit) {});
  }
}
