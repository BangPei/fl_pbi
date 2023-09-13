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
    'fullName': FormControl<String>(
      value: '',
      validators: [Validators.required],
    ),
    'gendre': FormControl<String>(),
    'birthPlace': FormControl<String>(),
    'birthDate': FormControl<DateTime>(),
    'religion': FormControl<String>(),
    'bloodGroup': FormControl<String>(),
    'email': FormControl<String>(),
    'phone': FormControl<String>(
      value: '',
      validators: [Validators.required],
    ),
    'currentAddress': FormControl<String>(
      value: '',
      validators: [Validators.required],
    ),
    'identity': FormGroup({
      'idNumber': FormControl<String>(
        value: '',
        validators: [Validators.required],
      ),
      'address': FormControl<String>(),
    }),
  });
  FormGroup mappingValue() {
    formgroup.value = profile?.toJson();
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
