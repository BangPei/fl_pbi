import 'package:fl_pbi/library/common.dart';
import 'package:fl_pbi/library/text_form_decoration.dart';
import 'package:fl_pbi/screen/official_letter/surat_lunas/lunas.dart';
import 'package:fl_pbi/screen/profile/data/profile.dart';
import 'package:fl_pbi/widget.dart/custom_form.dart';
import 'package:fl_pbi/widget.dart/cuttom_formfield.dart';
import 'package:fl_pbi/widget.dart/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SuratLunasScreen extends StatefulWidget {
  const SuratLunasScreen({super.key});

  @override
  State<SuratLunasScreen> createState() => _SuratLunasScreenState();
}

class _SuratLunasScreenState extends State<SuratLunasScreen> {
  late FocusNode _dateFocusNode;
  Profile? profile;
  bool isLoading = false;
  @override
  void initState() {
    // isLoading = true;
    // Session.get("profile").then((value) {
    //   profile = Profile.fromJson(jsonDecode(value ?? "{}"));
    //   formgroup.control('name').value = profile?.fullName ?? "";
    //   formgroup.control('phone').value = profile?.phone ?? "";
    //   formgroup.control('address').value = profile?.currentAddress ?? "";
    //   isLoading = false;
    //   setState(() {});
    // });
    _dateFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _dateFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Scaffold(body: Center(child: LoadingScreen()))
        : CustomForm(
            title: 'Form Surat Keterangan Lunas',
            onSubmit: () {
              // SuratLunas lunas = SuratLunas.fromJson(formgroup.value);
              // context.pushNamed("preview-pdf", extra: {
              //   "data": lunas,
              //   "pdf": lunas.pdf(),
              //   "title":
              //       "Surat Keterangan Lunas ${DateTime.now().millisecond.toString()}"
              // });
            },
            action: IconButton(
              icon: const Icon(Icons.download),
              onPressed: () {
                context.pushNamed("preview-pdf", extra: {
                  "data": SuratLunas(),
                  "pdf": SuratLunas().pdf(),
                  "title":
                      "Surat Keterangan Lunas ${DateTime.now().millisecond.toString()}"
                });
              },
            ),
            children: [
              CustomFormField(
                title: "Nama Pengelola",
                textForm: TextFormField(
                  // initialValue: state.profile?.gendre,
                  decoration: TextFormDecoration.box(),
                ),
              ),
              CustomFormField(
                title: "No. KTP Pengelola",
                textForm: TextFormField(
                  // initialValue: state.profile?.gendre,
                  keyboardType: TextInputType.number,
                  inputFormatters: [Common.ktpFormat],
                  decoration: TextFormDecoration.box(),
                ),
              ),
              CustomFormField(
                title: "Posisi / Jabatan Pengelola",
                textForm: TextFormField(
                  // initialValue: state.profile?.gendre,
                  decoration: TextFormDecoration.box(),
                ),
              ),
              CustomFormField(
                title: "No. Telp Pengelola",
                textForm: TextFormField(
                  // initialValue: state.profile?.gendre,
                  decoration: TextFormDecoration.box(),
                ),
              ),
              CustomFormField(
                title: "Alamat Pengelola",
                textForm: TextFormField(
                  // initialValue: state.profile?.gendre,
                  decoration: TextFormDecoration.box(),
                  maxLines: 3,
                  minLines: 3,
                ),
              ),
              CustomFormField(
                title: "No. Blok",
                textForm: TextFormField(
                  // initialValue: state.profile?.gendre,
                  decoration: TextFormDecoration.box(),
                ),
              ),
              // CustomFormField(
              //   title: "Tanggal Lunas",
              //   reactiveForm: CustomDatePicker(
              //     focusNode: _dateFocusNode,
              //     formGroup: formgroup,
              //     formControlName: "date",
              //     onCloseDatepicker: (val) {},
              //   ),
              // ),
            ],
          );
  }
}
