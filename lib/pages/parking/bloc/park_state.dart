part of 'park_bloc.dart';

final class ParkingState extends Equatable {
  const ParkingState({
    this.cashFlow,
    this.cardLoaing = true,
    this.loadMore = true,
    this.listLoading = true,
    this.isError = false,
    this.errorMessage,
    this.trans,
    this.parks,
    this.serverSide,
  });

  final CashFlow? cashFlow;
  final bool cardLoaing;
  final bool listLoading;
  final bool isError;
  final bool loadMore;
  final String? errorMessage;
  final List<Trans>? trans;
  final List<Transaction>? parks;
  final ServerSide? serverSide;

  ParkingState copyWith({
    CashFlow? cashFlow,
    bool? cardLoaing,
    bool? loadMore,
    bool? listLoading,
    bool? isError,
    List<Trans>? trans,
    String? errorMessage,
    ServerSide? serverSide,
    List<Transaction>? parks,
  }) {
    return ParkingState(
      cashFlow: cashFlow ?? this.cashFlow,
      cardLoaing: cardLoaing ?? this.cardLoaing,
      isError: isError ?? this.isError,
      loadMore: loadMore ?? this.loadMore,
      listLoading: listLoading ?? this.listLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      parks: parks ?? this.parks,
      serverSide: serverSide ?? this.serverSide,
      trans: trans ?? this.trans,
    );
  }

  @override
  List<Object?> get props => [
        cardLoaing,
        cashFlow,
        isError,
        errorMessage,
        parks,
        serverSide,
        listLoading,
        loadMore,
        trans,
      ];
}
