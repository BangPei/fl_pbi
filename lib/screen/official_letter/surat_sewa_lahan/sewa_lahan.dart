import 'package:jiffy/jiffy.dart';

class SuratSewaLahan {
  String? name;
  String? phone;
  String? address;
  String? nik;
  String? ownerName;
  String? date;
  String? areaName;
  String? areaCompany;
  int? wide;
  int? extraTime;
  int? periodeRent;
  String? periodeDate;

  SuratSewaLahan({
    this.address = "......................................",
    this.nik = "......................................",
    this.phone = "......................................",
    this.name = "......................................",
    this.ownerName = "......................................",
    this.date,
    this.areaName = "......................................",
    this.areaCompany = "......................................",
    this.periodeDate,
    this.wide = 0,
    this.extraTime = 0,
    this.periodeRent = 0,
  });

  SuratSewaLahan.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    nik = json['nik'];
    phone = json['phone'];
    address = json['address'];
    ownerName = json['ownerName'];
    date = json['date'] == null
        ? json['date']
        : Jiffy.parseFromDateTime(json['date']).format(pattern: "dd MMMM yyyy");
    areaName = json['areaName'];
    areaCompany = json['areaCompany'];
    periodeDate = json['periodeDate'] == null
        ? json['periodeDate']
        : Jiffy.parseFromDateTime(json['periodeDate'])
            .format(pattern: "dd MMMM yyyy");
    wide = json['wide'];
    extraTime = json['extraTime'];
    periodeRent = json['periodeRent'];
  }
}
