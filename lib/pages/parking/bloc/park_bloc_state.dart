part of 'park_bloc_bloc.dart';

sealed class ParkBlocState extends Equatable {
  const ParkBlocState();
  
  @override
  List<Object> get props => [];
}

final class ParkBlocInitial extends ParkBlocState {}
