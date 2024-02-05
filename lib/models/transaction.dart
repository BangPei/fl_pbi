import 'package:fl_pbi/models/models.dart';
import 'package:fl_pbi/pages/block/data/block_details.dart';

class Transaction {
  int? id;
  String? code;
  double? amount;
  String? date;
  int? type;
  String? note;
  String? remark;
  String? picture;
  String? createdAt;
  String? updatedAt;
  User? createdBy;
  BlockDetail? blockDetail;

  Transaction({
    this.id,
    this.code,
    this.amount,
    this.date,
    this.type,
    this.note,
    this.picture,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.remark,
    this.blockDetail,
  });

  Transaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    amount = double.parse(json['amount']);
    date = json['date'];
    type = json['type'];
    note = json['note'];
    remark = json['remark'];
    picture = json['picture'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy =
        json['created_by'] != null ? User.fromJson(json['created_by']) : null;
    blockDetail = json['block_detail'] != null
        ? BlockDetail.fromJson(json['block_detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['amount'] = amount;
    data['date'] = date;
    data['type'] = type;
    data['note'] = note;
    data['remark'] = remark;
    data['picture'] = picture;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (createdBy != null) {
      data['created_by'] = createdBy!.toJson();
    }
    if (blockDetail != null) {
      data['block_detail'] = blockDetail!.toJson();
    } else {
      data['block_detail'] = null;
    }
    return data;
  }
}
