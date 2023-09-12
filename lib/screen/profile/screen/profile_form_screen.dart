import 'package:fl_pbi/library/common.dart';
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
  @override
  void initState() {
    context.read<ProfileFormBloc>().add(const GetCurrentUserEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileFormBloc, ProfileFormState>(
      listener: (context, state) {
        if (state.isSuccess) {
          Common.modalInfo(
            context,
            title: "Success",
            message: "Berhasil Merubah Data",
            mode: MODE.success,
          );
        }
      },
      child: BlocBuilder<ProfileFormBloc, ProfileFormState>(
          builder: (context, state) {
        if (state.isLoading) {
          return const Scaffold(body: Center(child: LoadingScreen()));
        }
        return CustomForm(
          formGroup: state.formgroup,
          title: "Edit Profile",
          buttonTitle: "Simpan",
          onSubmit: () {
            if (state.formgroup.valid) {
              context.read<ProfileFormBloc>().add(const OnSubmitProfile());
            }
          },
          children: [
            CustomFormField(
              title: "Nama Depan",
              reactiveForm: ReactiveTextField(
                formControlName: 'firstName',
                onChanged: (val) {
                  String vals = val.value as String;
                  context.read<ProfileFormBloc>().add(OnFirstNameChanged(vals));
                },
                decoration: TextFormDecoration.box(),
              ),
            ),
            CustomFormField(
              title: "Nama Belakang",
              reactiveForm: ReactiveTextField(
                formControlName: 'lastName',
                onChanged: (val) {
                  String vals = val.value as String;
                  context.read<ProfileFormBloc>().add(OnLastNameChanged(vals));
                },
                decoration: TextFormDecoration.box(),
              ),
            ),
            CustomFormField(
              title: "Alamat Email",
              reactiveForm: ReactiveTextField(
                formControlName: 'email',
                onChanged: (val) {
                  String vals = val.value as String;
                  context.read<ProfileFormBloc>().add(OnEmailChanged(vals));
                },
                decoration: TextFormDecoration.box(),
              ),
            ),
            CustomFormField(
              title: "No. Tlp",
              reactiveForm: ReactiveTextField(
                formControlName: 'phone',
                onChanged: (val) {
                  String vals = val.value as String;
                  context.read<ProfileFormBloc>().add(OnPhoneChanged(vals));
                },
                decoration: TextFormDecoration.box(),
              ),
            ),
            CustomFormField(
              title: "Alamat Tinggal Saat Ini",
              reactiveForm: ReactiveTextField(
                formControlName: 'currentAddress',
                maxLines: 3,
                minLines: 3,
                onChanged: (val) {
                  String vals = val.value as String;
                  context
                      .read<ProfileFormBloc>()
                      .add(OnCurrAddressChanged(vals));
                },
                decoration: TextFormDecoration.box(),
              ),
            ),
          ],
        );
      }),
    );
  }
}
