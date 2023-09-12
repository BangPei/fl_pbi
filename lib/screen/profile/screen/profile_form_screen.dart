import 'package:fl_pbi/library/text_form_decoration.dart';
import 'package:fl_pbi/screen/profile/bloc/profile_form_bloc.dart';
import 'package:fl_pbi/widget.dart/custom_form.dart';
import 'package:fl_pbi/widget.dart/cuttom_formfield.dart';
import 'package:fl_pbi/widget.dart/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  });

  @override
  void initState() {
    context.read<ProfileFormBloc>().add(const GetCurrentUserEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileFormBloc, ProfileFormState>(
        builder: (context, state) {
      if (state.isLoading) {
        return const Scaffold(body: Center(child: LoadingScreen()));
      }
      return CustomForm(
        formGroup: formgroup,
        title: "Edit Profile",
        buttonTitle: "Simpan",
        onSubmit: () {},
        children: [
          CustomFormField(
            title: "Nama Depan",
            reactiveForm: ReactiveTextField(
              formControlName: 'firstName',
              onSubmitted: (val) {},
              decoration: TextFormDecoration.box(),
            ),
          ),
          CustomFormField(
            title: "Nama Belakang",
            reactiveForm: ReactiveTextField(
              formControlName: 'lastName',
              onSubmitted: (val) {},
              decoration: TextFormDecoration.box(),
            ),
          ),
          CustomFormField(
            title: "Alamat Email",
            reactiveForm: ReactiveTextField(
              formControlName: 'email',
              onSubmitted: (val) {},
              decoration: TextFormDecoration.box(),
            ),
          ),
          CustomFormField(
            title: "No. Tlp",
            reactiveForm: ReactiveTextField(
              formControlName: 'phone',
              onSubmitted: (val) {},
              decoration: TextFormDecoration.box(),
            ),
          ),
          CustomFormField(
            title: "Alamat Tinggal Saat Ini",
            reactiveForm: ReactiveTextField(
              formControlName: 'currentAddress',
              maxLines: 3,
              minLines: 3,
              onSubmitted: (val) {},
              decoration: TextFormDecoration.box(),
            ),
          ),
        ],
      );
    });
  }
}
