import 'package:equatable/equatable.dart';
import 'package:fl_pbi/models/cash_flow.dart';
import 'package:fl_pbi/models/serverside.dart';
import 'package:fl_pbi/pages/ipl/data/ipl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'ipl_event.dart';
part 'ipl_state.dart';

class IplBloc extends Bloc<IplEvent, IplState> {
  IplBloc() : super(const IplState()) {
    on<IplEvent>((event, emit) {});
  }
}
