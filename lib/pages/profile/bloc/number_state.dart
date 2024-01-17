part of 'number_bloc.dart';

final class NumberState extends Equatable {
  const NumberState({
    this.errorMessage,
    this.isLoading = false,
    this.isError = false,
    this.isSuccess = false,
    this.numbers,
    this.number,
  });

  final List<Number>? numbers;
  final String? errorMessage;
  final String? number;
  final bool isLoading;
  final bool isError;
  final bool isSuccess;

  NumberState copyWith({
    bool? isLoading,
    String? errorMessage,
    String? number,
    bool? isError,
    bool? isSuccess,
    List<Number>? numbers,
  }) {
    return NumberState(
      numbers: numbers ?? this.numbers,
      number: number ?? this.number,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isSuccess,
        number,
        numbers,
        isError,
        errorMessage,
      ];
}
