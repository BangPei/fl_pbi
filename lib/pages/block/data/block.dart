import 'package:fl_pbi/models/number.dart';

class Block {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  List<Number>? numbers;

  Block({this.id, this.name, this.createdAt, this.updatedAt, this.numbers});

  Block.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['numbers'] != null) {
      numbers = <Number>[];
      json['numbers'].forEach((v) {
        numbers!.add(Number.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (numbers != null) {
      data['numbers'] = numbers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
