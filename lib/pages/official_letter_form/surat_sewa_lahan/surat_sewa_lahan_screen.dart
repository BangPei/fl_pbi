import 'package:fl_pbi/pages/official_letter_form/surat_sewa_lahan/bloc/sewa_lahan_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../library/library_file.dart';
import '../../../widget/widget_file.dart';

class SuratSewaLahanScreen extends StatefulWidget {
  const SuratSewaLahanScreen({super.key});

  @override
  State<SuratSewaLahanScreen> createState() => _SuratSewaLahanScreenState();
}

class _SuratSewaLahanScreenState extends State<SuratSewaLahanScreen> {
  late FocusNode dateFocusNode;
  late FocusNode periodeDateFocusNode;
  TextEditingController dateController = TextEditingController();
  TextEditingController periodeDateController = TextEditingController();

  @override
  void initState() {
    dateFocusNode = FocusNode();
    periodeDateFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    dateFocusNode.dispose();
    periodeDateFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomForm(
      title: 'Form Surat Sewa Lahan',
      onSubmit: () {
        context.read<SewaLahanBloc>().add(const OnSubmit());
      },
      action: IconButton(
        icon: const Icon(Icons.download),
        onPressed: () {
          context.read<SewaLahanBloc>().add(const OnSubmitTemplate());
        },
      ),
      children: [
        CustomFormField(
          title: "Tanggal Perjanjian",
          textForm: BlocBuilder<SewaLahanBloc, SewaLahanState>(
              builder: (context, state) {
            return CustomDatePicker(
              focusNode: dateFocusNode,
              // validator: ValidForm.emptyValue,
              onCloseDatepicker: (val) {
                context
                    .read<SewaLahanBloc>()
                    .add(OnChangedTanggalPerjanjian(val: val));
                setState(() {});
              },
              controller: dateController,
            );
          }),
        ),
        CustomFormField(
          title: "Pihak Pertama",
          textForm: TextFormField(
            initialValue: ownerName.toUpperCase(),
            // validator: ValidForm.emptyValue,
            onChanged: (val) {
              context.read<SewaLahanBloc>().add(OnChangedPihakPertama(val));
            },
            decoration: TextFormDecoration.box(),
          ),
        ),
        CustomFormField(
          title: "Pihak Kedua",
          textForm: TextFormField(
            // validator: ValidForm.emptyValue,
            onChanged: (val) {
              context.read<SewaLahanBloc>().add(OnChangedPihakKedua(val));
            },
            decoration: TextFormDecoration.box(),
          ),
        ),
        CustomFormField(
          title: "No. KTP Pihak Kedua",
          textForm: TextFormField(
            // validator: ValidForm.emptyValue,
            onChanged: (val) {
              context.read<SewaLahanBloc>().add(OnChangedNik(val));
            },
            decoration: TextFormDecoration.box(),
            keyboardType: TextInputType.number,
            inputFormatters: [Common.ktpFormat],
          ),
        ),
        CustomFormField(
          title: "No.Tlp Pihak Kedua",
          textForm: TextFormField(
            // validator: ValidForm.emptyValue,
            onChanged: (val) {
              context.read<SewaLahanBloc>().add(OnChangedPhone(val));
            },
            decoration: TextFormDecoration.box(),
          ),
        ),
        CustomFormField(
          title: "Alamat Pihak Kedua",
          textForm: TextFormField(
            // validator: ValidForm.emptyValue,
            onChanged: (val) {
              context.read<SewaLahanBloc>().add(OnChangedAddress(val));
            },
            maxLines: 3,
            minLines: 3,
            decoration: TextFormDecoration.box(),
          ),
        ),
        CustomFormField(
          title: "Area Lahan",
          textForm: TextFormField(
            // validator: ValidForm.emptyValue,
            onChanged: (val) {
              context.read<SewaLahanBloc>().add(OnChangedAreaLahan(val));
            },
            decoration: TextFormDecoration.box(),
          ),
        ),
        CustomFormField(
          title: "Pemilik Area",
          textForm: TextFormField(
            initialValue: areaCompany.toUpperCase(),
            // validator: ValidForm.emptyValue,
            onChanged: (val) {
              context.read<SewaLahanBloc>().add(OnChangedPemilikArea(val));
            },
            decoration: TextFormDecoration.box(),
          ),
        ),
        CustomFormField(
          title: "Luas Area (Meter persegi)",
          textForm: TextFormField(
            // validator: ValidForm.emptyValue,
            onChanged: (val) {
              if (val.isNotEmpty) {
                double luas = double.parse(val.replaceAll(",", ""));
                context.read<SewaLahanBloc>().add(OnChangedLuasArea(luas));
              }
            },
            decoration: TextFormDecoration.box(),
            textAlign: TextAlign.end,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CurrencyInputFormatter(),
            ],
          ),
        ),
        CustomFormField(
          title: "Durasi Sewa Lahan (Tahun)",
          textForm: BlocBuilder<SewaLahanBloc, SewaLahanState>(
              builder: (context, state) {
            return TextFormField(
              //
              // validator: ValidForm.emptyValue,
              onChanged: (val) {
                if (val.isNotEmpty) {
                  int luas = int.parse(val.replaceAll(",", ""));
                  context.read<SewaLahanBloc>().add(OnChangedDurasiSewa(luas));
                  setState(() {});
                }
              },
              textAlign: TextAlign.end,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CurrencyInputFormatter(),
              ],
              decoration: TextFormDecoration.box(),
            );
          }),
        ),
        // CustomFormField(
        //   title: "Durasi Perpanjangan (Tahun)",
        //   textForm: TextFormField(
        //     // validator: ValidForm.emptyValue,
        //     onChanged: (val) {
        //       if (val.isNotEmpty) {
        //         int luas = int.parse(val.replaceAll(",", ""));
        //         context
        //             .read<SewaLahanBloc>()
        //             .add(OnChangedDurasiPerpanjangan(luas));
        //       }
        //     },
        //     textAlign: TextAlign.end,
        //     inputFormatters: [
        //       FilteringTextInputFormatter.digitsOnly,
        //       CurrencyInputFormatter(),
        //     ],
        //     decoration: TextFormDecoration.box(),
        //   ),
        // ),
        CustomFormField(
          title: "Periode Sewa Lahan",
          textForm: BlocBuilder<SewaLahanBloc, SewaLahanState>(
              builder: (context, state) {
            return CustomDatePicker(
              focusNode: periodeDateFocusNode,
              // validator: ValidForm.emptyValue,
              onCloseDatepicker: (val) {
                context
                    .read<SewaLahanBloc>()
                    .add(OnChangedPeriodeSewaLahan(val: val));
                setState(() {});
              },
              controller: periodeDateController,
            );
          }),
        ),
        // CustomFormField(
        //   title: "Periode Sewa Lahan",
        //   textForm: BlocBuilder<SewaLahanBloc, SewaLahanState>(
        //       builder: (context, state) {
        //     String? newDate = state.sewaLahan?.periodeDate;
        //     return TextFormField(
        //       controller: TextEditingController(
        //         text: (newDate == null)
        //             ? null
        //             : Jiffy.parse(newDate).format(pattern: "dd MMMM yyyy"),
        //       ),
        //       readOnly: true,
        //       decoration: TextFormDecoration.box(),
        //     );
        //   }),
        // ),
      ],
    );
  }
}
