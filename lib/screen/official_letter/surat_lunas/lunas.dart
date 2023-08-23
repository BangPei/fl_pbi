import 'package:jiffy/jiffy.dart';

class SuratLunas {
  String? name;
  String? phone;
  String? address;
  String? nik;
  String? position;
  String? date;
  String? block;

  SuratLunas({
    this.address = "......................................",
    this.nik = "......................................",
    this.phone = "......................................",
    this.name = "......................................",
    this.position = "......................................",
    this.block = ".....................",
    this.date = "......................................",
  });

  SuratLunas.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    nik = json['nik'];
    phone = json['phone'];
    address = json['address'];
    position = json['position'];
    date = json['date'] == null
        ? json['date']
        : Jiffy.parseFromDateTime(json['date']).format(pattern: "dd MMMM yyyy");
    block = json['block'];
  }
}
