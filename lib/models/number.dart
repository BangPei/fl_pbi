class Number {
  int? id;
  String? name;
  dynamic data;

  Number({this.name, this.id, this.data});

  Number.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['data'] = data;
    return data;
  }
}
