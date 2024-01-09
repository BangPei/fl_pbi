part of 'park_bloc.dart';

final class ParkingState extends Equatable {
  const ParkingState({
    this.cashFlow,
    this.cardLoaing = true,
    this.listLoading = true,
    this.isError = false,
    this.errorMessage,
    this.parks,
    this.serverSide,
  });

  final CashFlow? cashFlow;
  final bool cardLoaing;
  final bool listLoading;
  final bool isError;
  final String? errorMessage;
  final List<Parking>? parks;
  final ServerSide? serverSide;

  ParkingState copyWith({
    CashFlow? cashFlow,
    bool? cardLoaing,
    bool? listLoading,
    bool? isError,
    String? errorMessage,
    ServerSide? serverSide,
    List<Parking>? parks,
  }) {
    return ParkingState(
      cashFlow: cashFlow ?? this.cashFlow,
      cardLoaing: cardLoaing ?? this.cardLoaing,
      isError: isError ?? this.isError,
      listLoading: listLoading ?? this.listLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      parks: parks ?? this.parks,
      serverSide: serverSide ?? this.serverSide,
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
      ];
}
