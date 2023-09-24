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
