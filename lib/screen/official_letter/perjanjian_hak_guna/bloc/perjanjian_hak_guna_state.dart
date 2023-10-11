part of 'perjanjian_hak_guna_bloc.dart';

class PerjanjianHakGunaState extends Equatable {
  final HakGuna? hakGuna;
  final bool? isLoading;
  const PerjanjianHakGunaState({this.hakGuna, this.isLoading});

  PerjanjianHakGunaState copyWith({HakGuna? hakGuna, bool? isLoading}) {
    return PerjanjianHakGunaState(
        hakGuna: hakGuna ?? this.hakGuna,
        isLoading: isLoading ?? this.isLoading);
  }

  @override
  List<Object?> get props => [hakGuna, isLoading];
}
