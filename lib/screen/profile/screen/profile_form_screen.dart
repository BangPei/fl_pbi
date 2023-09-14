import 'package:fl_pbi/library/common.dart';
import 'package:fl_pbi/library/text_form_decoration.dart';
import 'package:fl_pbi/screen/profile/bloc/profile_form_bloc.dart';
import 'package:fl_pbi/widget.dart/custom_form.dart';
import 'package:fl_pbi/widget.dart/cuttom_formfield.dart';
import 'package:fl_pbi/widget.dart/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({super.key});

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  late FocusNode _dateFocusNode;

  @override
  void initState() {
    _dateFocusNode = FocusNode();
    context.read<ProfileFormBloc>().add(const GetCurrentUserEvent());
    super.initState();
  }

  @override
  void dispose() {
    _dateFocusNode.dispose();
    super.dispose();
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
        return state.isLoading
            ? const Scaffold(body: Center(child: LoadingScreen()))
            : CustomForm(
                title: "Edit Profile",
                buttonTitle: "Simpan",
                onSubmit: () {
                  context.read<ProfileFormBloc>().add(const OnSubmitProfile());
                },
                children: [
                  CustomFormField(
                    title: "Nama Lengkap Sesuai KTP",
                    textForm: TextFormField(
                      initialValue: state.profile?.fullName,
                      onChanged: (val) {},
                      decoration: TextFormDecoration.box(),
                    ),
                  ),
                  CustomFormField(
                    title: "No KTP",
                    textForm: TextFormField(
                      initialValue: state.profile?.identity?.idNumber,
                      onChanged: (val) {},
                      decoration: TextFormDecoration.box(),
                      keyboardType: TextInputType.number,
                      inputFormatters: [Common.ktpFormat],
                    ),
                  ),
                  CustomFormField(
                    title: "Tempat Lahir",
                    textForm: TextFormField(
                      initialValue: state.profile?.birthPlace,
                      onChanged: (val) {},
                      decoration: TextFormDecoration.box(),
                    ),
                  ),
                  // CustomFormField(
                  //   title: "Tanggal Lahir",
                  //   reactiveForm: CustomDatePicker(
                  //     focusNode: _dateFocusNode,
                  //     formGroup: state.formgroup,
                  //     formControlName: "birthDate",
                  //   ),
                  // ),
                  CustomFormField(
                    title: "Jenis Kelamin",
                    textForm: TextFormField(
                      initialValue: state.profile?.gendre,
                      onChanged: (val) {},
                      decoration: TextFormDecoration.box(),
                    ),
                  ),
                  CustomFormField(
                    title: "Gol. Darah",
                    textForm: TextFormField(
                      initialValue: state.profile?.bloodGroup,
                      onChanged: (val) {},
                      decoration: TextFormDecoration.box(),
                    ),
                  ),
                  // CustomFormField(
                  //   title: "Agama",
                  //   reactiveForm: ReactiveDropdownField<String>(
                  //     hint: const Text('Pilih Agama'),
                  //     formControlName: 'religion',
                  //     decoration: TextFormDecoration.box(),
                  //     items: const [
                  //       DropdownMenuItem(value: "islam", child: Text("Islam")),
                  //       DropdownMenuItem(
                  //           value: "katholik", child: Text("Katholik")),
                  //       DropdownMenuItem(
                  //           value: "protestan", child: Text("Protestan")),
                  //       DropdownMenuItem(value: "hindu", child: Text("Hindu")),
                  //       DropdownMenuItem(value: "budha", child: Text("Budha")),
                  //     ],
                  //   ),
                  // ),
                  CustomFormField(
                    title: "Alamat Email",
                    textForm: TextFormField(
                      initialValue: state.profile?.email,
                      onChanged: (val) {},
                      decoration: TextFormDecoration.box(),
                    ),
                  ),
                  CustomFormField(
                    title: "No. Tlp",
                    textForm: TextFormField(
                      initialValue: state.profile?.phone,
                      onChanged: (val) {},
                      decoration: TextFormDecoration.box(),
                    ),
                  ),
                  CustomFormField(
                    title: "Alamat Tinggal Saat Ini",
                    textForm: TextFormField(
                      initialValue: state.profile?.currentAddress,
                      onChanged: (val) {},
                      maxLines: 3,
                      minLines: 3,
                      decoration: TextFormDecoration.box(),
                    ),
                  ),
                  CustomFormField(
                    title: "Alamat Tinggal Sesuai KTP",
                    textForm: TextFormField(
                      initialValue: state.profile?.identity?.address,
                      onChanged: (val) {},
                      maxLines: 3,
                      minLines: 3,
                      decoration: TextFormDecoration.box(),
                    ),
                  ),
                ],
              );
      }),
    );
  }
}
