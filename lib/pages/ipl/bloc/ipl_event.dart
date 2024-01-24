part of 'ipl_bloc.dart';

abstract class IplEvent extends Equatable {
  const IplEvent();
}

class OnGetTotal extends IplEvent {
  @override
  List<Object?> get props => [];
}

class OnGetTrans extends IplEvent {
  final String year, type;
  const OnGetTrans(this.year, this.type);
  @override
  List<Object?> get props => [];
}