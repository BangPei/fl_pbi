part of 'finanace_bloc.dart';

sealed class FinanaceState extends Equatable {
  const FinanaceState();
  
  @override
  List<Object> get props => [];
}

final class FinanaceInitial extends FinanaceState {}
