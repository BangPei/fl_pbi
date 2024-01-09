import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'park_bloc_event.dart';
part 'park_bloc_state.dart';

class ParkBlocBloc extends Bloc<ParkBlocEvent, ParkBlocState> {
  ParkBlocBloc() : super(ParkBlocInitial()) {
    on<ParkBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
