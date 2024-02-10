import 'package:fl_pbi/library/library_file.dart';
import 'package:fl_pbi/pages/block/company/data/company.dart';
import 'package:fl_pbi/pages/category/data/category.dart';
import 'package:fl_pbi/widget/widget_file.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CompanyFormScreen extends StatefulWidget {
  final int? id;
  const CompanyFormScreen({super.key, this.id});

  @override
  State<CompanyFormScreen> createState() => _CompanyFormScreenState();
}

class _CompanyFormScreenState extends State<CompanyFormScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomForm(
      title: "Detail Kios/Lahan",
      onSubmit: () => context.pop<Company>(Company()),
      buttonTitle: "Simpan",
      showCard: false,
      children: [
        CustomFormField(
          title: "Nama Usaha",
          textForm: TextFormField(
            validator: ValidForm.emptyValue,
            keyboardType: TextInputType.number,
            decoration: TextFormDecoration.box(),
            onChanged: (val) {},
          ),
        ),
        CustomFormField(
          title: "Blok",
          textForm: DropdownWidget<Category>(
            isVisible: true,
            items: const [],
            selectedItem: Category(),
            onChanged: (val) {},
            child: (item) {
              return const ListTile(
                title: Text("ok"),
              );
            },
          ),
        ),
      ],
    );
  }
}
