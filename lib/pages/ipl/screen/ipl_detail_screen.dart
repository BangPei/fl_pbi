import 'package:fl_pbi/library/library_file.dart';
import 'package:fl_pbi/pages/block/data/block.dart';
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
  @override
  void initState() {
    Map<String, dynamic> map = {
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
      body: SingleChildScrollView(
        child: BlocBuilder<IplBloc, IplState>(
          builder: (context, state) {
            if (state.cardLoaing) {}
            return ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: (state.blocks ?? []).length,
              itemBuilder: (context, i) {
                Block block = (state.blocks ?? [])[i];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ExpansionPanelList(
                    children: [
                      ExpansionPanel(
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return ListTile(
                            title: Text("Block ${block.name}"),
                          );
                        },
                        body: Column(
                          children: (block.details ?? []).map((e) {
                            return ListTile(
                              title: Text(e.name ?? ""),
                              leading: const Icon(
                                FontAwesomeIcons.building,
                                color: AppTheme.blue,
                              ),
                              trailing: const Icon(Icons.arrow_right),
                              subtitle: (e.ipls ?? []).isEmpty
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
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Column(
                                      children: (e.ipls ?? []).map((f) {
                                        return Text(
                                            Common.oCcy.format(f.amount));
                                      }).toList(),
                                    ),
                            );
                          }).toList(),
                        ),
                        isExpanded: true,
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
