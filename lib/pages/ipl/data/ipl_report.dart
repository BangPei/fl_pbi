import 'package:fl_pbi/pages/ipl/data/ipl.dart';

class IPLReport {
  List<IPL>? transIn;
  List<IPL>? transOut;
  String? totalIn;
  String? totlaOut;

  IPLReport({this.transIn, this.transOut, this.totalIn, this.totlaOut});

  IPLReport.fromJson(Map<String, dynamic> json) {
    if (json['transIn'] != null) {
      transIn = <IPL>[];
      json['transIn'].forEach((v) {
        transIn!.add(IPL.fromJson(v));
      });
    }
    if (json['transOut'] != null) {
      transOut = <IPL>[];
      json['transOut'].forEach((v) {
        transOut!.add(IPL.fromJson(v));
      });
    }
    totalIn = json['totalIn'];
    totlaOut = json['totlaOut'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (transIn != null) {
      data['transIn'] = transIn!.map((v) => v.toJson()).toList();
    }
    if (transOut != null) {
      data['transOut'] = transOut!.map((v) => v.toJson()).toList();
    }
    data['totalIn'] = totalIn;
    data['totlaOut'] = totlaOut;
    return data;
  }
}
