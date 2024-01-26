import 'package:fl_pbi/library/app_theme.dart';
import 'package:fl_pbi/library/common.dart';
import 'package:fl_pbi/pages/ipl/bloc/ipl_bloc.dart';
import 'package:fl_pbi/widget.dart/button_in_out.dart';
import 'package:fl_pbi/widget.dart/card_total.dart';
import 'package:fl_pbi/widget.dart/custom_appbar.dart';
import 'package:fl_pbi/widget.dart/form_title.dart';
import 'package:fl_pbi/widget.dart/list_transaction.dart';
import 'package:fl_pbi/widget.dart/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class IPLScreen extends StatefulWidget {
  const IPLScreen({super.key});

  @override
  State<IPLScreen> createState() => _ParkingScreenState();
}

class _ParkingScreenState extends State<IPLScreen> {
  String year = "2024";
  String type = "1";
  @override
  void initState() {
    context.read<IplBloc>().add(OnGetTotal());
    context.read<IplBloc>().add(OnGetTrans(year, type));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Summary Uang IPL",
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        actions: IconButton(
          visualDensity: const VisualDensity(vertical: -4),
          onPressed: () {},
          icon: const FaIcon(FontAwesomeIcons.clockRotateLeft),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: GestureDetector(
        onTap: () {
          Common.dialogInOutCome(
            context,
            onTapIn: () {
              context.goNamed("ipl-form");
            },
            onTapOut: () {},
          );
        },
        child: Container(
          width: 110,
          decoration: BoxDecoration(
            color: AppTheme.blue,
            borderRadius: BorderRadius.circular(6),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 10,
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(
                FontAwesomeIcons.circlePlus,
                size: 15,
                color: Colors.white,
              ),
              SizedBox(width: 2),
              Text(
                "Input IPL",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<IplBloc>().add(OnGetTotal());
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<IplBloc, IplState>(
                  builder: (context, state) {
                    if (state.cardLoaing) {
                      return const LoadingScreen();
                    }
                    return CardTotal(
                      data: state.cashFlow?.rest,
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const FormTitle(
                      title: "Total IPL PerBulan Tahun ",
                      fontSize: 15,
                      padding: EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 20,
                      ),
                    ),
                    InkWell(
                      child: Text(
                        year,
                        style: const TextStyle(
                          color: AppTheme.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      onTap: () {
                        Common.yearPicker(
                          selecteYear: int.parse(year),
                          context: context,
                          onTap: (dt) {
                            year = dt.year.toString();
                            context.read<IplBloc>().add(OnGetTrans(year, type));
                            setState(() {});
                          },
                        );
                      },
                    )
                  ],
                ),
                ButtonInOut(
                  onTap: (idx) {
                    type = idx >= 1 ? "2" : "1";
                    setState(() {});
                    context.read<IplBloc>().add(OnGetTrans(year, type));
                  },
                ),
                BlocBuilder<IplBloc, IplState>(
                  builder: (context, state) {
                    if (state.listLoading) {
                      return const LoadingScreen();
                    }
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: ListTransaction(
                        trans: state.trans ?? [],
                        type: int.parse(type),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
