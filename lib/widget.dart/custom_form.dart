import 'package:fl_pbi/widget.dart/custom_Botton.dart';
import 'package:fl_pbi/widget.dart/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class CustomForm extends StatefulWidget {
  final String title;
  final String? buttonTitle;
  final List<Widget> children;
  final Function onSubmit;
  final Widget? action;
  final bool? showCard;
  const CustomForm({
    super.key,
    required this.title,
    required this.onSubmit,
    required this.children,
    this.buttonTitle,
    this.action,
    this.showCard = true,
  });

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: widget.title,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        actions: widget.action,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: (widget.showCard ?? true)
              ? Card(
                  child: BodyForm(
                    buttonTitle: widget.buttonTitle,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        widget.onSubmit();
                      }
                    },
                    children: widget.children,
                  ),
                )
              : BodyForm(
                  buttonTitle: widget.buttonTitle,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      widget.onSubmit();
                    }
                  },
                  children: widget.children,
                ),
        ),
      ),
    );
  }
}

class BodyForm extends StatelessWidget {
  final List<Widget> children;
  final String? buttonTitle;
  final VoidCallback? onPressed;
  const BodyForm(
      {super.key, required this.children, this.buttonTitle, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        children: [
          ListView(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            children: children,
          ),
          Center(
            child: SizedBox(
              width: 150,
              child: CustomButton(
                title: Text(buttonTitle ?? 'Print'),
                icon: const FaIcon(
                  FontAwesomeIcons.solidFloppyDisk,
                  color: Colors.white,
                  size: 20,
                ),
                onPressed: onPressed,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ValidForm {
  static String? dropDownEmpty(String? value) {
    if (value == null) {
      return "Tidak Boleh Kosong";
    }
    return null;
  }

  static String? emptyValue(String? value) {
    if (value!.isEmpty) {
      return "Tidak Boleh Kosong";
    }
    return null;
  }

  static String? matchValue(String? value, String? data, String title) {
    if (value!.isEmpty) {
      return "Tidak Boleh Kosong";
    } else {
      if (value != data) {
        return "$title Tidak Sesuai";
      }
    }
    return null;
  }

  static String? greaterThan(String? value, String? data, String title) {
    double val = double.parse((value =
            (value == "" || value == null) ? "0" : value)
        .replaceAll(",", ""));
    double vals = double.parse(data ?? "0");
    if (val <= vals) {
      return "harus lebih besar dari $title";
    }
    return null;
  }
}
