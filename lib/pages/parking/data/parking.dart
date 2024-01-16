import 'package:fl_pbi/models/user.dart';

class Parking {
  int? id;
  int? amount;
  String? code;
  String? date;
  int? type;
  String? remark;
  String? picture;
  String? createdAt;
  String? updatedAt;
  User? createdBy;

  Parking({
    this.id,
    this.amount,
    this.date,
    this.code,
    this.type,
    this.remark,
    this.picture,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
  });

  Parking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    code = json['code'];
    date = json['date'];
    type = json['type'];
    remark = json['remark'];
    picture = json['picture'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy =
        json['created_by'] != null ? User.fromJson(json['created_by']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['amount'] = amount;
    data['date'] = date;
    data['code'] = code;
    data['type'] = type;
    data['remark'] = remark;
    data['picture'] = picture;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (createdBy != null) {
      data['created_by'] = createdBy!.toJson();
    }
    return data;
  }
}
