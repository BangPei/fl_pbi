import 'package:fl_pbi/pages/block/data/block_details.dart';

class Block {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  List<BlockDetail>? details;

  Block({this.id, this.name, this.createdAt, this.updatedAt, this.details});

  Block.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['details'] != null) {
      details = <BlockDetail>[];
      json['details'].forEach((v) {
        details!.add(BlockDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (details != null) {
      data['details'] = details!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
