import 'package:fl_pbi/library/common.dart';
import 'package:fl_pbi/library/currency_formater.dart';
import 'package:fl_pbi/library/text_form_decoration.dart';
import 'package:fl_pbi/screen/official_letter/surat_sewa_lahan/bloc/sewa_lahan_bloc.dart';
import 'package:fl_pbi/screen/official_letter/surat_sewa_lahan/sewa_lahan.dart';
import 'package:fl_pbi/widget.dart/custom_form.dart';
import 'package:fl_pbi/widget.dart/custom_formfield.dart';
import 'package:fl_pbi/widget.dart/custome_datepicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jiffy/jiffy.dart';

class SuratSewaLahanScreen extends StatefulWidget {
  const SuratSewaLahanScreen({super.key});

  @override
  State<SuratSewaLahanScreen> createState() => _SuratSewaLahanScreenState();
}

class _SuratSewaLahanScreenState extends State<SuratSewaLahanScreen> {
  late FocusNode dateFocusNode;
  TextEditingController dateController = TextEditingController();
  TextEditingController periodeDateController = TextEditingController();
  @override
  void initState() {
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
    return CustomForm(
      title: 'Form Surat Sewa Lahan',
      onSubmit: () {
        // SuratSewaLahan sewaLahan = SuratSewaLahan.fromJson(formgroup.value);
        // context.pushNamed("preview-pdf", extra: {
        //   "data": sewaLahan,
        //   "pdf": sewaLahan.pdf(),
        //   "title": "Surat Permohonan ${DateTime.now().millisecond.toString()}"
        // });
      },
      action: IconButton(
        icon: const Icon(Icons.download),
        onPressed: () {
          context.pushNamed("preview-pdf", extra: {
            "data": SuratSewaLahan(),
            "pdf": SuratSewaLahan().pdf(),
            "title": "Surat Sewa Lahan${DateTime.now().millisecond.toString()}"
          });
        },
      ),
      children: [
        CustomFormField(
          title: "Tanggal Perjanjian",
          textForm: CustomDatePicker(
            key: UniqueKey(),
            focusNode: dateFocusNode,
            validator: ValidForm.emptyValue,
            onCloseDatepicker: (val) {
              context
                  .read<SewaLahanBloc>()
                  .add(OnChangedTanggalPerjanjian(val: val));
            },
            controller: dateController,
          ),
        ),
        CustomFormField(
          title: "Pihak Pertama",
          textForm: TextFormField(
            key: UniqueKey(),
            validator: ValidForm.emptyValue,
            onChanged: (val) {
              context.read<SewaLahanBloc>().add(OnChangedPihakPertama(val));
            },
            decoration: TextFormDecoration.box(),
          ),
        ),
        CustomFormField(
          title: "Pihak Kedua",
          textForm: TextFormField(
            key: UniqueKey(),
            validator: ValidForm.emptyValue,
            onChanged: (val) {
              context.read<SewaLahanBloc>().add(OnChangedPihakKedua(val));
            },
            decoration: TextFormDecoration.box(),
          ),
        ),
        CustomFormField(
          title: "No. KTP Pihak Kedua",
          textForm: TextFormField(
            key: UniqueKey(),
            validator: ValidForm.emptyValue,
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
            key: UniqueKey(),
            validator: ValidForm.emptyValue,
            onChanged: (val) {
              context.read<SewaLahanBloc>().add(OnChangedPhone(val));
            },
            decoration: TextFormDecoration.box(),
          ),
        ),
        CustomFormField(
          title: "Alamat Pihak Kedua",
          textForm: TextFormField(
            key: UniqueKey(),
            validator: ValidForm.emptyValue,
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
            key: UniqueKey(),
            validator: ValidForm.emptyValue,
            onChanged: (val) {
              context.read<SewaLahanBloc>().add(OnChangedAreaLahan(val));
            },
            decoration: TextFormDecoration.box(),
          ),
        ),
        CustomFormField(
          title: "Pemilik Area",
          textForm: TextFormField(
            key: UniqueKey(),
            validator: ValidForm.emptyValue,
            onChanged: (val) {
              context.read<SewaLahanBloc>().add(OnChangedPemilikArea(val));
            },
            decoration: TextFormDecoration.box(),
          ),
        ),
        CustomFormField(
          title: "Luas Area (Meter persegi)",
          textForm: TextFormField(
            key: UniqueKey(),
            validator: ValidForm.emptyValue,
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
          textForm: TextFormField(
            key: UniqueKey(),
            validator: ValidForm.emptyValue,
            onChanged: (val) {
              if (val.isNotEmpty) {
                int luas = int.parse(val.replaceAll(",", ""));
                context.read<SewaLahanBloc>().add(OnChangedDurasiSewa(luas));
              }
            },
            textAlign: TextAlign.end,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CurrencyInputFormatter(),
            ],
            decoration: TextFormDecoration.box(),
          ),
        ),
        CustomFormField(
          title: "Durasi Perpanjangan (Tahun)",
          textForm: TextFormField(
            key: UniqueKey(),
            validator: ValidForm.emptyValue,
            onChanged: (val) {
              if (val.isNotEmpty) {
                int luas = int.parse(val.replaceAll(",", ""));
                context
                    .read<SewaLahanBloc>()
                    .add(OnChangedDurasiPerpanjangan(luas));
              }
            },
            textAlign: TextAlign.end,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CurrencyInputFormatter(),
            ],
            decoration: TextFormDecoration.box(),
          ),
        ),
        CustomFormField(
          title: "Periode Sewa Lahan",
          textForm: BlocBuilder<SewaLahanBloc, SewaLahanState>(
            buildWhen: (prev, curr) {
              return prev.sewaLahan?.periodeDate != curr.sewaLahan?.periodeDate;
            },
            builder: (context, state) {
              if (state.sewaLahan?.periodeDate != null) {
                periodeDateController.text =
                    Jiffy.parse(state.sewaLahan!.periodeDate!)
                        .format(pattern: "dd MMMM yyyy");
              } else {
                periodeDateController.text.isEmpty;
              }
              return TextFormField(
                key: UniqueKey(),
                // initialValue: state.sewaLahan?.periodeDate,
                controller: periodeDateController,
                readOnly: true,
                decoration: TextFormDecoration.box(),
              );
            },
          ),
        ),
      ],
    );
  }
}
