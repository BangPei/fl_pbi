part of 'park_bloc.dart';

abstract class ParkingEvent extends Equatable {
  const ParkingEvent();
}

class OnGetTotal extends ParkingEvent {
  @override
  List<Object?> get props => [];
}

class OnGetSummary extends ParkingEvent {
  final Map<String, dynamic>? map;
  const OnGetSummary({this.map});
  @override
  List<Object?> get props => [];
}

class OnLoadMore extends ParkingEvent {
  @override
  List<Object?> get props => [];
}

class OnRemovePark extends ParkingEvent {
  final int? id;
  const OnRemovePark(this.id);
  @override
  List<Object?> get props => [];
}

class OnGetTrans extends ParkingEvent {
  final String year, type;
  const OnGetTrans(this.year, this.type);
  @override
  List<Object?> get props => [];
}
