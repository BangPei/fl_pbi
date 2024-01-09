import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'park_bloc_event.dart';
part 'park_bloc_state.dart';

class ParkBlocBloc extends Bloc<ParkBlocEvent, ParkBlocState> {
  ParkBlocBloc() : super(ParkBlocInitial()) {
    on<ParkBlocEvent>((event, emit) {});
  }
}
