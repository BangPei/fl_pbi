part of 'form_ipl_bloc.dart';

final class FormIplState extends Equatable {
  const FormIplState({
    this.blockDetails,
    this.errorMessage,
    this.ipl,
    this.isError = false,
    this.isSuccess = false,
    this.isLoading = false,
  });

  final bool isLoading;
  final bool isSuccess;
  final bool isError;
  final String? errorMessage;
  final List<BlockDetail>? blockDetails;
  final IPL? ipl;

  FormIplState copyWith({
    bool? isLoading,
    bool? isError,
    bool? isSuccess,
    String? errorMessage,
    List<BlockDetail>? blockDetails,
    IPL? ipl,
  }) {
    return FormIplState(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      blockDetails: blockDetails ?? this.blockDetails,
      ipl: ipl ?? this.ipl,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isError,
        errorMessage,
        ipl,
        isSuccess,
      ];
}
