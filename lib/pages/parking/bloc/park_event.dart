part of 'park_bloc.dart';

abstract class ParkingEvent extends Equatable {
  const ParkingEvent();
}

class OnGetTotal extends ParkingEvent {
  @override
  List<Object?> get props => [];
}

class OnGetSummary extends ParkingEvent {
  @override
  List<Object?> get props => [];
}
