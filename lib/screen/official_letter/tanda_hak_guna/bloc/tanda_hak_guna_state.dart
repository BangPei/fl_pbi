part of 'tanda_hak_guna_bloc.dart';

class TandaHakGunaState extends Equatable {
  final HakGuna? hakGuna;
  final bool? isLoading;
  const TandaHakGunaState({this.hakGuna, this.isLoading});

  TandaHakGunaState copyWith({HakGuna? hakGuna, bool? isLoading}) {
    return TandaHakGunaState(
        hakGuna: hakGuna ?? this.hakGuna,
        isLoading: isLoading ?? this.isLoading);
  }

  @override
  List<Object?> get props => [hakGuna, isLoading];
}
