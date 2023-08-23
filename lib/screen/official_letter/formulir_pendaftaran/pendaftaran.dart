class Pendaftaran {
  String? name;
  String? phone;
  String? address;
  String? nik;
  String? pic;
  String? block;

  Pendaftaran({
    this.address = "......................................",
    this.nik = "......................................",
    this.phone = "......................................",
    this.name = "......................................",
    this.pic = "......................................",
    this.block = ".....................",
  });

  Pendaftaran.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    nik = json['nik'];
    phone = json['phone'];
    address = json['address'];
    pic = json['pic'];
    block = json['block'];
  }
}
