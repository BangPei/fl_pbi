import 'package:fl_pbi/models/number.dart';

class IPL {
  int? id;
  String? code;
  double? amount;
  String? date;
  int? type;
  String? note;
  String? picture;
  Number? number;

  IPL(
      {this.id,
      this.code,
      this.amount,
      this.date,
      this.type,
      this.note,
      this.picture,
      this.number});

  IPL.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    amount = json['amount'];
    date = json['date'];
    type = json['type'];
    note = json['note'];
    picture = json['picture'];
    number = json['number'] != null ? Number.fromJson(json['number']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['amount'] = amount;
    data['date'] = date;
    data['type'] = type;
    data['note'] = note;
    data['picture'] = picture;
    if (number != null) {
      data['number'] = number!.toJson();
    }
    return data;
  }
}
