import 'package:fl_pbi/library/app_theme.dart';
import 'package:fl_pbi/pages/parking/bloc/park_bloc.dart';
import 'package:fl_pbi/pages/parking/card_summary.dart';
import 'package:fl_pbi/pages/parking/list_screen.dart';
import 'package:fl_pbi/widget.dart/custom_appbar.dart';
import 'package:fl_pbi/widget.dart/form_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class ParkingScreen extends StatefulWidget {
  const ParkingScreen({super.key});

  @override
  State<ParkingScreen> createState() => _ParkingScreenState();
}

class _ParkingScreenState extends State<ParkingScreen> {
  final ScrollController _controller = ScrollController();
  @override
  void initState() {
    _controller.addListener(() {
      if (_controller.position.maxScrollExtent == _controller.offset) {
        context.read<ParkingBloc>().add(OnLoadMore());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: CustomAppbar(
        title: "Summary Uang Parkir",
        actions: IconButton(
          visualDensity: const VisualDensity(vertical: -4),
          onPressed: dialogInOutCome,
          icon: const FaIcon(FontAwesomeIcons.plus),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<ParkingBloc>().add(OnGetSummary());
          context.read<ParkingBloc>().add(OnGetTotal());
        },
        child: SingleChildScrollView(
          controller: _controller,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CardSummary(),
                const FormTitle(
                  title: "Histori Uang Masuk dan Keluar",
                  padding: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 20,
                  ),
                ),
                const ListSummaryScreen(),
                BlocBuilder<ParkingBloc, ParkingState>(
                  builder: (context, state) {
                    if (state.loadMore) {
                      return const SizedBox(
                        height: 70,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  dialogInOutCome() {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            height: 230,
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Pilih Transaksi',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 19),
                          ),
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            child: const Icon(
                              FontAwesomeIcons.xmark,
                              size: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        buttonTrans(
                          title: "Uang Masuk",
                          backgroundColor:
                              const Color.fromARGB(255, 154, 11, 211)
                                  .withOpacity(0.7),
                          onTap: () => context
                              .goNamed("keuangan-form", extra: {"type": 1}),
                        ),
                        const SizedBox(width: 10),
                        buttonTrans(
                          title: "Uang Keluar",
                          backgroundColor:
                              const Color.fromARGB(255, 221, 13, 31)
                                  .withOpacity(0.7),
                          onTap: () {},
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 25.0),
                      child: Divider(),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Expanded buttonTrans(
      {required String title, VoidCallback? onTap, Color? backgroundColor}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                color: AppTheme.white,
                fontWeight: FontWeight.w700,
                fontSize: 20,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
