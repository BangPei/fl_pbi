class PerjanjianHakGuna {
  Pic? pic;
  Customer? customer;
  Kios? kios;
  String? date;

  PerjanjianHakGuna({this.pic, this.customer, this.kios, this.date});

  PerjanjianHakGuna.fromJson(Map<String, dynamic> json) {
    pic = json['pic'] != null ? Pic.fromJson(json['pic']) : null;
    customer =
        json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    kios = json['kios'] != null ? Kios.fromJson(json['kios']) : null;
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pic != null) {
      data['pic'] = pic!.toJson();
    }
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    if (kios != null) {
      data['kios'] = kios!.toJson();
    }
    data['date'] = date;
    return data;
  }
}

class Pic {
  String? name;
  String? dateBirth;
  String? job;
  String? address;
  String? nik;
  String? phone;

  Pic(
      {this.name,
      this.dateBirth,
      this.job,
      this.address,
      this.nik,
      this.phone});

  Pic.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    dateBirth = json['dateBirth'];
    job = json['job'];
    address = json['address'];
    nik = json['nik'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['dateBirth'] = dateBirth;
    data['job'] = job;
    data['address'] = address;
    data['nik'] = nik;
    data['phone'] = phone;
    return data;
  }
}

class Customer {
  String? name;
  String? job;
  String? address;
  String? nik;
  String? phone;

  Customer({this.name, this.job, this.address, this.nik, this.phone});

  Customer.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    job = json['job'];
    address = json['address'];
    nik = json['nik'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['job'] = job;
    data['address'] = address;
    data['nik'] = nik;
    data['phone'] = phone;
    return data;
  }
}

class Kios {
  String? location;
  String? block;
  String? blockNo;
  int? totalKios;
  int? kiosWide;
  int? periodeRent;
  String? startDate;
  String? endDate;
  double? monthCost;
  double? electricCost;
  String? signHakGuna;

  Kios(
      {this.location,
      this.block,
      this.blockNo,
      this.totalKios,
      this.kiosWide,
      this.periodeRent,
      this.startDate,
      this.endDate,
      this.monthCost,
      this.electricCost,
      this.signHakGuna});

  Kios.fromJson(Map<String, dynamic> json) {
    location = json['location'];
    block = json['block'];
    blockNo = json['blockNo'];
    totalKios = json['totalKios'];
    kiosWide = json['kiosWide'];
    periodeRent = json['periodeRent'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    monthCost = json['monthCost'];
    electricCost = json['electricCost'];
    signHakGuna = json['signHakGuna'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['location'] = location;
    data['block'] = block;
    data['blockNo'] = blockNo;
    data['totalKios'] = totalKios;
    data['kiosWide'] = kiosWide;
    data['periodeRent'] = periodeRent;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['monthCost'] = monthCost;
    data['electricCost'] = electricCost;
    data['signHakGuna'] = signHakGuna;
    return data;
  }
}
