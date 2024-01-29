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

class OnGetSummary extends IplEvent {
  final Map<String, dynamic>? map;
  const OnGetSummary({this.map});
  @override
  List<Object?> get props => [];
}

class OnChangedPanelOpen extends IplEvent {
  final bool expand;
  final int index;
  const OnChangedPanelOpen(this.index, this.expand);
  @override
  List<Object?> get props => [];
}
