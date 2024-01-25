import 'package:fl_pbi/models/number.dart';

class BlockDetail {
  int? id;
  String? code;
  Number? number;
  String? name;
  double? width;
  int? length;
  double? wide;
  int? price;
  String? picture;
  String? createdAt;
  String? updatedAt;
  bool? isBase64;

  BlockDetail({
    this.id,
    this.code,
    this.number,
    this.name,
    this.width,
    this.length,
    this.wide,
    this.price,
    this.picture,
    this.createdAt,
    this.updatedAt,
    this.isBase64,
  });

  BlockDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    number = json['number'] != null ? Number.fromJson(json['number']) : null;
    name = json['name'];
    width = json['width'];
    length = json['length'];
    wide = json['wide'];
    price = json['price'];
    picture = json['picture'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
