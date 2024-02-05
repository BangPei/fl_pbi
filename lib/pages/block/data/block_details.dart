import 'package:fl_pbi/models/models.dart';

class BlockDetail {
  int? id;
  String? code;
  Number? number;
  String? name;
  double? width;
  double? length;
  double? wide;
  double? price;
  String? picture;
  String? createdAt;
  String? updatedAt;
  bool? isBase64;
  List<Transaction>? ipls;

  BlockDetail(
      {this.id,
      this.code,
      this.number,
      this.name,
      this.width = 0,
      this.length = 0,
      this.wide = 0,
      this.price = 0,
      this.picture,
      this.createdAt,
      this.updatedAt,
      this.isBase64,
      this.ipls});

  BlockDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    number = json['number'] != null ? Number.fromJson(json['number']) : null;
    name = json['name'];
    width = double.parse(json['width']);
    length = double.parse(json['length']);
    wide = double.parse(json['wide']);
    price = double.parse(json['price']);
    picture = json['picture'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['ipls'] != null) {
      ipls = <Transaction>[];
      json['ipls'].forEach((v) {
        ipls!.add(Transaction.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    if (number != null) {
      data['number'] = number!.toJson();
    }
    data['name'] = name;
    data['width'] = width;
    data['length'] = length;
    data['wide'] = wide;
    data['price'] = price;
    data['picture'] = picture;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
