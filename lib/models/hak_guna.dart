import 'package:fl_pbi/models/customer.dart';
import 'package:fl_pbi/models/kios.dart';
import 'package:fl_pbi/models/pic.dart';

class HakGuna {
  String? no;
  String? createdAt;
  String? createdPlace;
  Pic? pic;
  Customer? customer;
  Kios? kios;

  HakGuna(
      {this.no,
      this.createdAt,
      this.createdPlace,
      this.pic,
      this.customer,
      this.kios});

  HakGuna.fromJson(Map<String, dynamic> json) {
    no = json['no'];
    createdAt = json['created_at'];
    createdPlace = json['created_place'];
    pic = json['pic'] != null ? Pic.fromJson(json['pic']) : null;
    customer =
        json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    kios = json['kios'] != null ? Kios.fromJson(json['kios']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['no'] = no;
    data['created_at'] = createdAt;
    data['created_place'] = createdPlace;
    if (pic != null) {
      data['pic'] = pic!.toJson();
    }
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    if (kios != null) {
      data['kios'] = kios!.toJson();
    }
    return data;
  }
}
