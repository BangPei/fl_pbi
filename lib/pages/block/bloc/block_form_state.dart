part of 'block_form_bloc.dart';

final class BlockFormState extends Equatable {
  const BlockFormState({
    this.isError = false,
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
    this.block,
  });

  final bool isLoading;
  final bool isError;
  final bool isSuccess;
  final String? errorMessage;
  final Block? block;

  BlockFormState copyWith({
    bool? isError,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    Block? block,
  }) {
    return BlockFormState(
      isError: isError ?? this.isError,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      block: block ?? this.block,
    );
  }

  @override
  List<Object?> get props =>
      [isError, isSuccess, errorMessage, isLoading, block];
}
