import 'package:fl_pbi/widget.dart/custom_form.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({super.key});

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final formgroup = FormGroup({
    'firstName': FormControl<String>(
      value: '',
      validators: [Validators.required],
    ),
    'lastName': FormControl<String>(
      value: '',
      validators: [Validators.required],
    ),
    'fullName': FormControl<String>(
      value: '',
    ),
    'email': FormControl<String>(
      value: '',
    ),
    'phone': FormControl<String>(
      value: '',
      validators: [Validators.required],
    ),
    'currentAddress': FormControl<String>(
      value: '',
      validators: [Validators.required],
    ),
    'idCardType': FormControl<String>(
      value: "",
      validators: [Validators.required],
    ),
  });
  @override
  Widget build(BuildContext context) {
    return CustomForm(
      formGroup: formgroup,
      title: "Edit Profile",
      buttonTitle: "Simpan",
      onSubmit: () {},
      children: [],
    );
  }
}
