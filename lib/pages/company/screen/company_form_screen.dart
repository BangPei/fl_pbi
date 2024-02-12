import 'package:fl_pbi/library/library_file.dart';
import 'package:fl_pbi/pages/block/data/block_details.dart';
import 'package:fl_pbi/pages/block/screen/card_block_number.dart';
import 'package:fl_pbi/pages/company/bloc/company_bloc.dart';
import 'package:fl_pbi/pages/company/data/company.dart';
import 'package:fl_pbi/pages/category/data/category.dart';
import 'package:fl_pbi/widget/widget_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CompanyFormScreen extends StatefulWidget {
  final int? id;
  const CompanyFormScreen({super.key, this.id});

  @override
  State<CompanyFormScreen> createState() => _CompanyFormScreenState();
}

class _CompanyFormScreenState extends State<CompanyFormScreen> {
  @override
  void initState() {
    context.read<CompanyBloc>().add(const OnInit());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyBloc, CompanyState>(
      builder: (context, state) {
        if (state.isLoading ?? false) {
          return const Scaffold(
            body: LoadingScreen(),
          );
        } else {
          return CustomForm(
            title: "Form Perusahaan",
            onSubmit: () => context.pop<Company>(state.company),
            buttonTitle: "Simpan",
            showCard: false,
            children: [
              CustomFormField(
                title: "Nama Usaha",
                textForm: TextFormField(
                  validator: ValidForm.emptyValue,
                  keyboardType: TextInputType.number,
                  decoration: TextFormDecoration.box(),
                  onChanged: (val) {
                    context.read<CompanyBloc>().add(OnChangedName(val));
                  },
                ),
              ),
              CustomFormField(
                title: "Jenis Usaha",
                textForm: DropdownWidget<Category>(
                  isVisible: true,
                  items: state.categories ?? [],
                  itemAsString: (p0) => p0.name ?? "Pilih Jenis Usaha",
                  selectedItem: state.company?.category,
                  onChanged: (val) {
                    context.read<CompanyBloc>().add(OnChangedCategory(val!));
                  },
                  child: (item) {
                    return ListTile(
                      title: Text(item.name ?? ""),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const FormTitle(
                      title: 'Data Kios/Lahan',
                      fontSize: 15,
                    ),
                    ElevatedButton.icon(
                      onPressed: () => modalBotom(state.blockDetails ?? []),
                      icon: const Icon(Icons.add),
                      label: const Text("Tambah"),
                    )
                  ],
                ),
              ),
              (state.company?.blockDetails ?? []).isEmpty
                  ? const EmptyCard()
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: (state.company?.blockDetails ?? []).map((e) {
                          return CardBlockNumber(
                            blockDetail: e,
                            onTap: () {},
                          );
                        }).toList(),
                      ),
                    )
            ],
          );
        }
      },
    );
  }

  modalBotom(List<BlockDetail> details) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    "Silahkan Pilih Blok",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: details.length,
                    itemBuilder: (context, i) {
                      BlockDetail block = details[i];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppTheme.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(255, 216, 216, 216),
                                spreadRadius: 0.2,
                                blurRadius: 2,
                                offset: Offset(0, 1),
                              )
                            ],
                          ),
                          child: ListTile(
                            onTap: () {
                              context
                                  .read<CompanyBloc>()
                                  .add(OnAddBlock(block));
                              setState(() {});
                              Navigator.pop(context);
                            },
                            dense: true,
                            title: Text(block.name ?? ""),
                            subtitle:
                                Text(block.company?.name ?? "Nama Usaha :"),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
