part of 'profile_form_bloc.dart';

final class ProfileFormState extends Equatable {
  final Profile? profile;
  final String? errorMessage;
  final bool isLoading;
  final bool isError;
  final bool isSuccess;

  ProfileFormState({
    this.profile,
    this.errorMessage,
    this.isLoading = false,
    this.isError = false,
    this.isSuccess = false,
  });

  ProfileFormState copyWith({
    Profile? profile,
    bool? isLoading,
    String? errorMessage,
    bool? isError,
    bool? isSuccess,
  }) {
    return ProfileFormState(
      profile: profile ?? this.profile,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        profile,
        isError,
        errorMessage,
        isSuccess,
      ];
}
