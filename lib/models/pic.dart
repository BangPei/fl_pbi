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
