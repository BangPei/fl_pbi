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

  final FormGroup formgroup = FormGroup({
    'firstName': FormControl<String>(
      value: '',
      validators: [Validators.required],
    ),
    'lastName': FormControl<String>(),
    'email': FormControl<String>(),
    'phone': FormControl<String>(
      value: '',
      validators: [Validators.required],
    ),
    'currentAddress': FormControl<String>(
      value: '',
      validators: [Validators.required],
    ),
  });
  FormGroup mappingValue() {
    formgroup.control('firstName').value = profile?.firstName ?? "";
    formgroup.control('lastName').value = profile?.lastName ?? "";
    formgroup.control('email').value = profile?.email ?? "";
    formgroup.control('phone').value = profile?.phone ?? "";
    formgroup.control('currentAddress').value = profile?.currentAddress ?? "";
    return formgroup;
  }

  @override
  List<Object?> get props => [
        isLoading,
        profile,
        isError,
        errorMessage,
        formgroup,
        isSuccess,
        mappingValue(),
      ];
}
