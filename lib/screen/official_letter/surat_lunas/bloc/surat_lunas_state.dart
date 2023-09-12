part of 'surat_lunas_bloc.dart';

final class SuratLunasState extends Equatable {
  SuratLunasState({this.profile});

  final Profile? profile;

  SuratLunasState copyWith({Profile? profile}) {
    return SuratLunasState(profile: profile ?? this.profile);
  }

  final FormGroup formgroup = FormGroup({
    'name': FormControl<String>(
      value: '',
      validators: [Validators.required],
    ),
    'phone': FormControl<String>(
      value: '',
      validators: [Validators.required],
    ),
    'nik': FormControl<String>(
      value: '',
      validators: [Validators.required],
    ),
    'address': FormControl<String>(
      value: '',
      validators: [Validators.required],
    ),
    'position': FormControl<String>(
      value: '',
      validators: [Validators.required],
    ),
    'block': FormControl<String>(
      value: '',
      validators: [Validators.required],
    ),
    'date': FormControl<DateTime>(
      value: null,
      validators: [Validators.required],
    ),
  });
  FormGroup mappingValue() {
    formgroup.control('name').value = profile?.fullName ?? "";
    formgroup.control('phone').value = profile?.phone ?? "";
    formgroup.control('currentAddress').value = profile?.currentAddress ?? "";
    return formgroup;
  }

  @override
  List<Object?> get props => [profile];
}
