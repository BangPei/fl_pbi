part of 'park_form_bloc.dart';

final class ParkFormState extends Equatable {
  const ParkFormState({
    this.listLoading = false,
    this.isError = false,
    this.isSuccess = false,
    this.errorMessage,
    this.park,
  });

  final bool listLoading;
  final bool isError;
  final bool isSuccess;
  final String? errorMessage;
  final Parking? park;

  ParkFormState copyWith({
    bool? listLoading,
    bool? isError,
    bool? isSuccess,
    String? errorMessage,
    Parking? park,
  }) {
    return ParkFormState(
      isError: isError ?? this.isError,
      listLoading: listLoading ?? this.listLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      park: park ?? this.park,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [
        isError,
        errorMessage,
        park,
        listLoading,
        isSuccess,
      ];
}
