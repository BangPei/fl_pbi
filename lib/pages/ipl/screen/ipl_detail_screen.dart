import 'package:fl_pbi/library/library_file.dart';
import 'package:fl_pbi/pages/block/data/block_details.dart';
import 'package:fl_pbi/pages/ipl/bloc/ipl_bloc.dart';
import 'package:fl_pbi/pages/ipl/data/ipl.dart';
import 'package:fl_pbi/widget/widget_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:jiffy/jiffy.dart';

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
              if (state.listLoading) {
                return const Center(child: LoadingScreen());
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Block ${e.name}",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 4.0),
                                        child: Badge(
                                          backgroundColor: const Color.fromARGB(
                                                  255, 21, 146, 25)
                                              .withOpacity(0.7),
                                          label: Text(
                                              "Total Kios : ${(e.details ?? []).length}"),
                                        ),
                                      ),
                                      Badge(
                                        backgroundColor: AppTheme.blue,
                                        label: Text(
                                            "Sudah Bayar : ${(e.details ?? []).where((d) => (d.ipls ?? []).isNotEmpty).length}"),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 4.0),
                                        child: Badge(
                                          backgroundColor:
                                              AppTheme.nearlyDarkRed,
                                          label: Text(
                                              "Belum Bayar : ${(e.details ?? []).where((d) => (d.ipls ?? []).isEmpty).length}"),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                          body: BodyDetail(
                            details: e.details ?? [],
                            month: widget.month,
                            year: widget.year,
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

class BodyDetail extends StatelessWidget {
  final List<BlockDetail> details;
  final int year;
  final String month;
  const BodyDetail(
      {super.key,
      required this.details,
      required this.year,
      required this.month});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
      child: Column(
        children: details.map((detail) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  rowHeader(context, detail: detail, year: year, month: month),
                  rowBody(detail.ipls ?? [], picture: detail.picture),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget rowHeader(
    BuildContext context, {
    required BlockDetail detail,
    required String month,
    required int year,
  }) {
    return InkWell(
      onTap: (detail.ipls ?? []).isNotEmpty
          ? null
          : () {
              context.goNamed("ipl-form", extra: {
                "type": 1,
                'blockCode': detail.code,
                'month': month,
                'year': year,
              });
            },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                detail.name ?? "",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              const Text(
                "Nama Usaha : ",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          Center(
            child: Badge(
              backgroundColor: (detail.ipls ?? []).isEmpty
                  ? AppTheme.nearlyDarkRed.withOpacity(0.8)
                  : AppTheme.blue.withOpacity(0.8),
              textColor: AppTheme.white,
              label: Text(
                (detail.ipls ?? []).isEmpty ? "Belum Bayar" : "Sudah Bayar",
                style:
                    const TextStyle(fontSize: 9, fontStyle: FontStyle.italic),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget rowBody(List<IPL> ipls, {String? picture}) {
    return Visibility(
      visible: ipls.isNotEmpty,
      child: Column(
        children: [
          const Divider(),
          Row(
            children: [
              picture != null
                  ? FadeInImage(
                      image: NetworkImage(picture, scale: 1),
                      placeholder: AssetImage(Common.imageBuilding),
                      imageErrorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          FontAwesomeIcons.building,
                          color: AppTheme.blue,
                          size: 45,
                        );
                      },
                      width: 40,
                      fit: BoxFit.fitWidth,
                    )
                  : const Icon(
                      FontAwesomeIcons.building,
                      color: AppTheme.blue,
                      size: 45,
                    ),
              const SizedBox(width: 8),
              Column(
                children: ipls.map((f) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            f.code ?? "",
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w700),
                          ),
                          Visibility(
                            visible: f.code != null,
                            replacement: const SizedBox.shrink(),
                            child: GestureDetector(
                              onTap: () async {
                                await Clipboard.setData(
                                    ClipboardData(text: f.code!));
                              },
                              child: const Icon(
                                Icons.copy_all_rounded,
                                color: AppTheme.blue,
                                size: 18,
                              ),
                            ),
                          )
                        ],
                      ),
                      rowDetail(
                          "Nominal IPL", "Rp. ${Common.oCcy.format(f.amount)}"),
                      rowDetail("Periode IPL",
                          Jiffy.parse(f.date!).format(pattern: "MMMM yyyy")),
                      rowDetail(
                          "Tgl Input",
                          Jiffy.parse(f.createdAt!)
                              .format(pattern: "dd MMMM yyyy")),
                    ],
                  );
                }).toList(),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget rowDetail(String title, String data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 75,
          child: Text(
            title,
            style: const TextStyle(fontSize: 12),
          ),
        ),
        const SizedBox(width: 20, child: Text(":")),
        Text(
          data,
          textAlign: TextAlign.justify,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
