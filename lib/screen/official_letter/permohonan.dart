class SuratPermohonan {
  String? name;
  String? phone;
  String? address;
  String? nik;

  SuratPermohonan({
    this.address = "......................................",
    this.nik = "......................................",
    this.phone = "......................................",
    this.name = "......................................",
  });

  SuratPermohonan.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    nik = json['nik'];
    phone = json['phone'];
    address = json['address'];
  }
}
