// ignore_for_file: avoid_print
import 'package:fl_pbi/library/library_file.dart';
import 'package:fl_pbi/pages/profile/bloc/profile_form_bloc.dart';
import 'package:fl_pbi/widget/widget_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({super.key});

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  late FocusNode _dateFocusNode;
  String? imageBase64;
  String? imageProfile;
  String? identityBase64;
  String? imageIdentity;
  TextEditingController dateController = TextEditingController();
  GlobalKey key = GlobalKey<State<StatefulWidget>>();

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
    Size size = MediaQuery.of(context).size;
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
        if (state.profile?.birthDate != null) {
          dateController.text = Jiffy.parse(state.profile!.birthDate!)
              .format(pattern: "dd MMMM yyyy");
        }
        imageIdentity = state.profile?.identity?.picture;
        imageProfile = state.profile?.picture;
      },
      child: BlocBuilder<ProfileFormBloc, ProfileFormState>(
          builder: (context, state) {
        return state.isLoading
            ? const Scaffold(body: Center(child: LoadingScreen()))
            : CustomForm(
                title: "Edit Profile",
                buttonTitle: "Simpan",
                onSubmit: () {
                  context.read<ProfileFormBloc>().add(OnSubmitProfile(
                        image: imageBase64,
                        identity: identityBase64,
                      ));
                },
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: SizedBox(
                          width: 100,
                          child: ImageCamera(
                            base64: imageBase64,
                            data: imageProfile,
                            onTap: (str) => imageBase64 = str,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            CustomFormField(
                              title: "Nama Lengkap Sesuai KTP",
                              textForm: TextFormField(
                                initialValue: state.profile?.fullName,
                                validator: ValidForm.emptyValue,
                                onChanged: (val) {
                                  context
                                      .read<ProfileFormBloc>()
                                      .add(OnChangedFullname(val));
                                },
                                decoration: TextFormDecoration.box(),
                              ),
                            ),
                            CustomFormField(
                              title: "No KTP",
                              textForm: TextFormField(
                                initialValue: state.profile?.identity?.idNumber,
                                validator: ValidForm.emptyValue,
                                onChanged: (val) {
                                  context
                                      .read<ProfileFormBloc>()
                                      .add(OnChangedNik(val));
                                },
                                decoration: TextFormDecoration.box(),
                                keyboardType: TextInputType.number,
                                inputFormatters: [Common.ktpFormat],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Wrap(
                    key: key,
                    children: [
                      SizedBox(
                        width: size.width * 49 / 100,
                        child: CustomFormField(
                          title: "Tempat Lahir",
                          textForm: TextFormField(
                            initialValue: state.profile?.birthPlace,
                            validator: ValidForm.emptyValue,
                            onChanged: (val) {
                              context
                                  .read<ProfileFormBloc>()
                                  .add(OnChangedBirthPlace(val));
                            },
                            decoration: TextFormDecoration.box(),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 48 / 100,
                        child: CustomFormField(
                          title: "Tanggal Lahir",
                          textForm: CustomDatePicker(
                            validator: ValidForm.emptyValue,
                            controller: dateController,
                            focusNode: _dateFocusNode,
                            onCloseDatepicker: (datetime) {
                              context
                                  .read<ProfileFormBloc>()
                                  .add(OnChangedBirthDate(val: datetime));
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    children: [
                      SizedBox(
                        width: size.width * 49 / 100,
                        child: CustomFormField(
                          title: "Jenis Kelamin",
                          textForm: DropdownButtonFormField<String>(
                            hint: const Text('Pilih Jenis Kelamin'),
                            value: state.profile?.gendre,
                            validator: ValidForm.emptyValue,
                            decoration: TextFormDecoration.box(),
                            onChanged: (val) {
                              context
                                  .read<ProfileFormBloc>()
                                  .add(OnChangedGender(val!));
                            },
                            items: const [
                              DropdownMenuItem(
                                  value: "L", child: Text("Laki - Laki")),
                              DropdownMenuItem(
                                  value: "P", child: Text("Perempuan")),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 48 / 100,
                        child: CustomFormField(
                          title: "Gol. Darah",
                          textForm: DropdownButtonFormField<String>(
                            hint: const Text('Golongan Darah'),
                            value: state.profile?.bloodGroup,
                            validator: ValidForm.emptyValue,
                            decoration: TextFormDecoration.box(),
                            onChanged: (val) {
                              context
                                  .read<ProfileFormBloc>()
                                  .add(OnChangedBloodGroup(val!));
                            },
                            items: const [
                              DropdownMenuItem(value: "A", child: Text("A")),
                              DropdownMenuItem(value: "B", child: Text("B")),
                              DropdownMenuItem(value: "AB", child: Text("AB")),
                              DropdownMenuItem(value: "O", child: Text("O")),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    children: [
                      SizedBox(
                        width: size.width * 49 / 100,
                        child: CustomFormField(
                          title: "Agama",
                          textForm: DropdownButtonFormField<String>(
                            hint: const Text('Pilih Agama'),
                            value: state.profile?.religion?.toLowerCase(),
                            validator: ValidForm.emptyValue,
                            decoration: TextFormDecoration.box(),
                            onChanged: (val) {
                              context
                                  .read<ProfileFormBloc>()
                                  .add(OnChangedReligion(val!));
                            },
                            items: const [
                              DropdownMenuItem(
                                  value: "islam", child: Text("Islam")),
                              DropdownMenuItem(
                                  value: "katholik", child: Text("Katholik")),
                              DropdownMenuItem(
                                  value: "protestan", child: Text("Protestan")),
                              DropdownMenuItem(
                                  value: "hindu", child: Text("Hindu")),
                              DropdownMenuItem(
                                  value: "budha", child: Text("Budha")),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 48 / 100,
                        child: CustomFormField(
                          title: "No. Tlp",
                          textForm: TextFormField(
                            validator: ValidForm.emptyValue,
                            initialValue: state.profile?.phone,
                            onChanged: (val) {
                              context
                                  .read<ProfileFormBloc>()
                                  .add(OnChangedPhone(val));
                            },
                            decoration: TextFormDecoration.box(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  CustomFormField(
                    title: "Alamat Email",
                    textForm: TextFormField(
                      initialValue: state.profile?.email,
                      onChanged: (val) {
                        context
                            .read<ProfileFormBloc>()
                            .add(OnChangedEmail(val));
                      },
                      decoration: TextFormDecoration.box(),
                    ),
                  ),
                  CustomFormField(
                    title: "Alamat Tinggal Saat Ini",
                    textForm: TextFormField(
                      validator: ValidForm.emptyValue,
                      initialValue: state.profile?.currentAddress,
                      onChanged: (val) {
                        context
                            .read<ProfileFormBloc>()
                            .add(OnChangedCurrAddress(val));
                      },
                      maxLines: 3,
                      minLines: 3,
                      decoration: TextFormDecoration.box(),
                    ),
                  ),
                  CustomFormField(
                    action: true,
                    title: "Alamat Tinggal Sesuai KTP",
                    textForm: TextFormField(
                      controller: TextEditingController(
                        text: state.profile?.identity?.address,
                      ),
                      onChanged: (val) {
                        context
                            .read<ProfileFormBloc>()
                            .add(OnChangedAddress(val));
                      },
                      maxLines: 3,
                      minLines: 3,
                      decoration: TextFormDecoration.box(),
                    ),
                    onChangeSwitch: (val) {
                      context.read<ProfileFormBloc>().add(OnChangedSwitch(val));
                      setState(() {});
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                      vertical: 5,
                    ),
                    child: ImageCamera(
                      base64: identityBase64,
                      data: imageIdentity,
                      onTap: (str) => identityBase64 = str,
                    ),
                  ),
                ],
              );
      }),
    );
  }
}
