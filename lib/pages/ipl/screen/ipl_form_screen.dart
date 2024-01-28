import 'package:dropdown_search/dropdown_search.dart';
import 'package:fl_pbi/library/library_file.dart';
import 'package:fl_pbi/pages/block/data/block_details.dart';
import 'package:fl_pbi/pages/ipl/bloc/form_ipl_bloc.dart';
import 'package:fl_pbi/widget/widget_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class IPLFormScreen extends StatefulWidget {
  final int type;
  final int? id;
  const IPLFormScreen({super.key, this.id, required this.type});

  @override
  State<IPLFormScreen> createState() => _IPLFormScreenState();
}

class _IPLFormScreenState extends State<IPLFormScreen> {
  late FocusNode dateFocusNode;
  String? evidentBase64;
  TextEditingController dateController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController remarkController = TextEditingController();

  @override
  void initState() {
    if (widget.id == null) {
      context.read<FormIplBloc>().add(OnInit());
    }
    dateFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    dateFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormIplBloc, FormIplState>(
      builder: (context, state) {
        if (state.isLoading) {
          return Scaffold(
            appBar: CustomAppbar(
              title: "IPL Form",
              leading: IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back),
              ),
            ),
            body: const Center(child: CircularProgressIndicator()),
          );
        }
        return CustomForm(
          title: "IPL Form",
          onSubmit: () {
            context
                .read<FormIplBloc>()
                .add(OnSubmit(type: 1, image: evidentBase64));
          },
          buttonTitle: "Simpan",
          children: [
            CustomFormField(
              title: "Periode",
              textForm: CustomDatePicker(
                display: DISPLAY.month,
                focusNode: dateFocusNode,
                validator: ValidForm.emptyValue,
                onCloseDatepicker: (val) {
                  context.read<FormIplBloc>().add(OnChangedDate(val!));
                },
                controller: dateController,
              ),
            ),
            CustomFormField(
              title: "Blok",
              textForm: DropdownWidget(state: state),
            ),
            CustomFormField(
              title: "Jumlah Uang",
              textForm: TextFormField(
                controller: amountController,
                validator: ValidForm.emptyValue,
                keyboardType: TextInputType.number,
                decoration: TextFormDecoration.box(),
                onChanged: (val) {
                  val = val == "" ? "0" : val;
                  double data = double.parse(val);
                  context.read<FormIplBloc>().add(OnChangedAmount(data));
                },
              ),
            ),
            CustomFormField(
              title: "Keterangan",
              textForm: TextFormField(
                controller: remarkController,
                validator: ValidForm.emptyValue,
                decoration: TextFormDecoration.box(),
                onChanged: (val) {
                  context.read<FormIplBloc>().add(OnChangedNote(val));
                },
              ),
            ),
            ImageCamera(
              base64: evidentBase64,
              data: state.ipl?.picture,
              onTap: (str) => evidentBase64 = str,
            ),
          ],
        );
      },
    );
  }
}

class DropdownWidget extends StatelessWidget {
  final FormIplState state;
  const DropdownWidget({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<BlockDetail>(
      selectedItem: state.ipl?.blockDetail ?? BlockDetail(),
      popupProps: PopupProps.modalBottomSheet(
        showSearchBox: true,
        searchDelay: const Duration(milliseconds: 500),
        itemBuilder: (context, item, isSelected) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 4.0,
              horizontal: 10,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 252, 253, 253),
                borderRadius: BorderRadius.circular(6),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 114, 100, 240),
                    spreadRadius: 0.2,
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  )
                ],
              ),
              child: ListTile(
                title: Text(
                  item.name ?? "",
                ),
              ),
            ),
          );
        },
        searchFieldProps: const TextFieldProps(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ),
      validator: (value) => ValidForm.emptyValue(value?.name),
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: TextFormDecoration.box(),
      ),
      onChanged: (BlockDetail? data) =>
          context.read<FormIplBloc>().add(OnChangedBlockDetail(data!)),
      items: state.blockDetails ?? [],
      itemAsString: (item) => item.name ?? "",
    );
  }
}
