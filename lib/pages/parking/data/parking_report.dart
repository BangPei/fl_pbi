import 'package:fl_pbi/pages/parking/data/parking.dart';

class ParkingReport {
  List<Parking>? transIn;
  List<Parking>? transOut;
  String? totalIn;
  String? totlaOut;

  ParkingReport({this.transIn, this.transOut, this.totalIn, this.totlaOut});

  ParkingReport.fromJson(Map<String, dynamic> json) {
    if (json['transIn'] != null) {
      transIn = <Parking>[];
      json['transIn'].forEach((v) {
        transIn!.add(Parking.fromJson(v));
      });
    }
    if (json['transOut'] != null) {
      transOut = <Parking>[];
      json['transOut'].forEach((v) {
        transOut!.add(Parking.fromJson(v));
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
