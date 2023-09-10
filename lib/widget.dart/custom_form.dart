import 'package:fl_pbi/widget.dart/custom_Botton.dart';
import 'package:fl_pbi/widget.dart/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:responsive_grid/responsive_grid.dart';

class CustomForm extends StatefulWidget {
  final FormGroup formGroup;
  final String title;
  final List<ResponsiveGridCol> children;
  final VoidCallback? onPrint;
  final VoidCallback? onDownload;
  const CustomForm({
    super.key,
    required this.formGroup,
    required this.title,
    this.onPrint,
    required this.children,
    this.onDownload,
  });

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: CustomAppbar(
          title: widget.title,
          leading: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back),
          ),
          actions: IconButton(
            icon: const Icon(Icons.download),
            onPressed: widget.onDownload,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: ReactiveForm(
          formGroup: widget.formGroup,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                children: [
                  ResponsiveGridRow(
                    children: widget.children,
                  ),
                  Center(
                    child: SizedBox(
                      width: 120,
                      child: CustomButton(
                        title: const Text('Print'),
                        icon: const FaIcon(
                          FontAwesomeIcons.print,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: widget.onPrint,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}