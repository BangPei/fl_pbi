import 'package:fl_pbi/library/library_file.dart';
import 'package:fl_pbi/widget/widget_file.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomerFormScreen extends StatefulWidget {
  const CustomerFormScreen({super.key});

  @override
  State<CustomerFormScreen> createState() => _CustomerFormScreenState();
}

class _CustomerFormScreenState extends State<CustomerFormScreen> {
  TextEditingController dateController = TextEditingController();
  late FocusNode _dateFocusNode;
  String? ktpBase64;

  @override
  void initState() {
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
    return CustomForm(
      showCard: false,
      title: "Form Customer",
      onSubmit: () {},
      buttonTitle: "Simpan",
      children: [
        CustomFormField(
          title: "Nama Lengkap",
          textForm: TextFormField(
            validator: ValidForm.emptyValue,
            keyboardType: TextInputType.number,
            decoration: TextFormDecoration.box(),
            onChanged: (val) {},
          ),
        ),
        CustomFormField(
          title: "No. Tlp",
          textForm: TextFormField(
            validator: ValidForm.emptyValue,
            onChanged: (val) {},
            decoration: TextFormDecoration.box(),
          ),
        ),
        CustomFormField(
          title: "Alamat Email",
          textForm: TextFormField(
            validator: ValidForm.emptyValue,
            keyboardType: TextInputType.number,
            decoration: TextFormDecoration.box(),
            onChanged: (val) {},
          ),
        ),
        CustomFormField(
          title: "NIK (Nomor Induk Kependudukan)",
          textForm: TextFormField(
            validator: ValidForm.emptyValue,
            onChanged: (val) {},
            decoration: TextFormDecoration.box(),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: CustomFormField(
                title: "Tempat Lahir",
                textForm: TextFormField(
                  validator: ValidForm.emptyValue,
                  onChanged: (val) {},
                  decoration: TextFormDecoration.box(),
                ),
              ),
            ),
            Expanded(
              child: CustomFormField(
                title: "Tanggal Lahir",
                textForm: CustomDatePicker(
                  validator: ValidForm.emptyValue,
                  controller: dateController,
                  focusNode: _dateFocusNode,
                  onCloseDatepicker: (datetime) {},
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: CustomFormField(
                title: "Jenis Kelamin",
                textForm: DropdownButtonFormField<String>(
                  hint: const Text('Jenis Kelamin'),
                  validator: ValidForm.emptyValue,
                  decoration: TextFormDecoration.box(),
                  onChanged: (val) {},
                  items: const [
                    DropdownMenuItem(value: "L", child: Text("Laki - Laki")),
                    DropdownMenuItem(value: "P", child: Text("Perempuan")),
                  ],
                ),
              ),
            ),
            Expanded(
              child: CustomFormField(
                title: "Gol. Darah",
                textForm: DropdownButtonFormField<String>(
                  hint: const Text('Gol. Darah'),
                  validator: ValidForm.emptyValue,
                  decoration: TextFormDecoration.box(),
                  onChanged: (val) {},
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
        CustomFormField(
          title: "Agama",
          textForm: DropdownButtonFormField<String>(
            hint: const Text('Pilih Agama'),
            validator: ValidForm.emptyValue,
            decoration: TextFormDecoration.box(),
            onChanged: (val) {},
            items: const [
              DropdownMenuItem(value: "islam", child: Text("Islam")),
              DropdownMenuItem(value: "katholik", child: Text("Katholik")),
              DropdownMenuItem(value: "protestan", child: Text("Protestan")),
              DropdownMenuItem(value: "hindu", child: Text("Hindu")),
              DropdownMenuItem(value: "budha", child: Text("Budha")),
            ],
          ),
        ),
        CustomFormField(
          title: "Alamat Tinggal Sesuai KTP",
          textForm: TextFormField(
            controller: TextEditingController(),
            onChanged: (val) {},
            maxLines: 3,
            minLines: 3,
            decoration: TextFormDecoration.box(),
          ),
        ),
        ImageCamera(
          title: "Lampiran (Foto KTP)",
          onTap: (str) {},
          base64: ktpBase64,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const FormTitle(
                title: 'Detail Kios/Lahan',
                fontSize: 15,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  context.pushNamed("company-form").then((value) {
                    print(value);
                  });
                },
                icon: const Icon(Icons.add),
                label: const Text("Tambah"),
              )
            ],
          ),
        ),
        const EmptyCard()
      ],
    );
  }
}
