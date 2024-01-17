part of 'block_bloc.dart';

final class BlockState extends Equatable {
  const BlockState({
    this.isError = false,
    this.isLoading = false,
    this.errorMessage,
    this.blocks,
  });

  final bool isLoading;
  final bool isError;
  final String? errorMessage;
  final List<Block>? blocks;

  BlockState copyWith({
    bool? isError,
    bool? isLoading,
    String? errorMessage,
    List<Block>? blocks,
  }) {
    return BlockState(
      isError: isError ?? this.isError,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      blocks: blocks ?? this.blocks,
    );
  }

  @override
  List<Object?> get props => [isError, errorMessage, isLoading, blocks];
}
