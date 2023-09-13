class IdentityCard {
  int? id;
  String? idNumber;
  String? address;

  String? picture;

  IdentityCard({
    this.id,
    this.idNumber,
    this.address,
    this.picture,
  });

  IdentityCard.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    idNumber = json['idNumber'];
    address = json['address'];

    picture = json['picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idNumber'] = idNumber;
    data['address'] = address;

    data['picture'] = picture;
    return data;
  }
}
