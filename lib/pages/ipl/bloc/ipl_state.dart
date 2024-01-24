part of 'ipl_bloc.dart';

final class IplState extends Equatable {
  const IplState({
    this.cashFlow,
    this.cardLoaing = true,
    this.loadMore = true,
    this.listLoading = true,
    this.isError = false,
    this.errorMessage,
    this.trans,
    this.ipls,
    this.serverSide,
  });

  final CashFlow? cashFlow;
  final bool cardLoaing;
  final bool listLoading;
  final bool isError;
  final bool loadMore;
  final String? errorMessage;
  final List<IPL>? ipls;
  final List<Trans>? trans;
  final ServerSide? serverSide;

  IplState copyWith({
    CashFlow? cashFlow,
    bool? cardLoaing,
    bool? loadMore,
    bool? listLoading,
    bool? isError,
    String? errorMessage,
    ServerSide? serverSide,
    List<IPL>? ipls,
    List<Trans>? trans,
  }) {
    return IplState(
      cashFlow: cashFlow ?? this.cashFlow,
      cardLoaing: cardLoaing ?? this.cardLoaing,
      isError: isError ?? this.isError,
      loadMore: loadMore ?? this.loadMore,
      listLoading: listLoading ?? this.listLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      ipls: ipls ?? this.ipls,
      trans: trans ?? this.trans,
      serverSide: serverSide ?? this.serverSide,
    );
  }

  @override
  List<Object?> get props => [
        cardLoaing,
        cashFlow,
        isError,
        errorMessage,
        ipls,
        trans,
        serverSide,
        listLoading,
        loadMore,
      ];
}
