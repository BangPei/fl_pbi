import 'package:fl_pbi/library/library_file.dart';
import 'package:fl_pbi/pages/ipl/bloc/ipl_bloc.dart';
import 'package:fl_pbi/widget/widget_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class IPLDetailScreen extends StatefulWidget {
  final int type, year;
  final String month;
  const IPLDetailScreen({
    super.key,
    required this.type,
    required this.year,
    required this.month,
  });

  @override
  State<IPLDetailScreen> createState() => _ParkingDetailScreenState();
}

class _ParkingDetailScreenState extends State<IPLDetailScreen> {
  Map<String, dynamic> map = {};
  @override
  void initState() {
    map = {
      "type": widget.type,
      "month": widget.month,
      "year": widget.year,
      "ipl": true,
      "details": true,
    };
    context.read<IplBloc>().add(OnGetSummary(map: map));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Detail IPL ${widget.month} ${widget.year}",
        subTitle: Badge(
          backgroundColor:
              widget.type == 1 ? AppTheme.blue : AppTheme.nearlyDarkRed,
          textColor: AppTheme.white,
          label: Text(widget.type == 1 ? "Pemasukan" : "Pengeluaran"),
        ),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<IplBloc>().add(OnGetSummary(map: map));
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: BlocBuilder<IplBloc, IplState>(
            builder: (context, state) {
              if (state.cardLoaing) {
                return const LoadingScreen();
              }
              return ExpansionPanelList(
                expandedHeaderPadding: const EdgeInsets.only(top: 6),
                expandIconColor: Colors.amber,
                animationDuration: const Duration(milliseconds: 1000),
                expansionCallback: (idx, expand) {
                  context.read<IplBloc>().add(OnChangedPanelOpen(idx, expand));
                  setState(() {});
                },
                children: (state.blocks ?? [])
                    .asMap()
                    .map((i, e) {
                      return MapEntry(
                        i,
                        ExpansionPanel(
                          canTapOnHeader: true,
                          isExpanded: state.listOpen?[i] ?? false,
                          headerBuilder: (context, isExpanded) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Block ${e.name}",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            );
                          },
                          body: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              children: (e.details ?? []).map((detail) {
                                return Card(
                                  child: ListTile(
                                      title: Text(detail.name ?? ""),
                                      trailing: const Icon(Icons.arrow_right),
                                      leading: const Icon(
                                        FontAwesomeIcons.building,
                                        color: AppTheme.blue,
                                        size: 30,
                                      ),
                                      subtitle: (detail.ipls ?? []).isEmpty
                                          ? Row(
                                              children: [
                                                Badge(
                                                  backgroundColor: AppTheme
                                                      .nearlyDarkRed
                                                      .withOpacity(0.8),
                                                  textColor: AppTheme.white,
                                                  label: const Text(
                                                    "Belum Bayar",
                                                    style: TextStyle(
                                                        fontSize: 9,
                                                        fontStyle:
                                                            FontStyle.italic),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Column(
                                              children:
                                                  (detail.ipls ?? []).map((f) {
                                                return Text(Common.oCcy
                                                    .format(f.amount));
                                              }).toList(),
                                            )),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      );
                    })
                    .values
                    .toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}
