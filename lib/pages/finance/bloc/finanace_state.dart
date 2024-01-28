part of 'finanace_bloc.dart';

final class FinanceState extends Equatable {
  const FinanceState({
    this.isError = false,
    this.errorMessage,
    this.finance,
    this.isLoading = false,
  });

  final Finance? finance;
  final bool isLoading;
  final bool isError;
  final String? errorMessage;

  FinanceState copyWith({
    Finance? finance,
    bool? isLoading,
    bool? isError,
    String? errorMessage,
  }) {
    return FinanceState(
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      finance: finance ?? this.finance,
    );
  }

  @override
  List<Object?> get props => [isError, errorMessage, isLoading, finance];
}
