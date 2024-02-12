import 'package:fl_pbi/pages/block/data/block_details.dart';
import 'package:fl_pbi/pages/category/data/category.dart';
import 'package:fl_pbi/pages/profile/data/profile.dart';

class Company {
  int? id;
  String? name;
  Category? category;
  Profile? owner;
  List<BlockDetail>? blockDetails;

  Company({
    this.id,
    this.name,
    this.category,
    this.owner,
    this.blockDetails,
  });

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['details'] != null) {
      blockDetails = <BlockDetail>[];
      json['blockDetails'].forEach((v) {
        blockDetails!.add(BlockDetail.fromJson(v));
      });
    }
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    owner = json['owner'] != null ? Profile.fromJson(json['owner']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (owner != null) {
      data['owner'] = owner!.toJson();
    }
    if (blockDetails != null) {
      data['blockDetails'] = blockDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
