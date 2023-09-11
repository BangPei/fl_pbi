import 'package:fl_pbi/screen/profile/data/profile.dart';

class IdentityCard {
  int? id;
  String? fullName;
  String? birthDate;
  String? birthPlace;
  String? gendre;
  String? address;
  String? rt;
  String? rw;
  String? district;
  String? subdistrict;
  String? province;
  String? religion;
  String? materialStatus;
  String? bloodGroup;
  String? job;
  String? citizenship;
  String? validDate;
  String? picture;
  Profile? profile;

  IdentityCard(
      {this.id,
      this.fullName,
      this.birthDate,
      this.birthPlace,
      this.gendre,
      this.address,
      this.rt,
      this.rw,
      this.district,
      this.subdistrict,
      this.province,
      this.religion,
      this.materialStatus,
      this.bloodGroup,
      this.job,
      this.citizenship,
      this.validDate,
      this.picture,
      this.profile});

  IdentityCard.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    birthDate = json['birthDate'];
    birthPlace = json['birthPlace'];
    gendre = json['gendre'];
    address = json['address'];
    rt = json['rt'];
    rw = json['rw'];
    district = json['district'];
    subdistrict = json['subdistrict'];
    province = json['province'];
    religion = json['religion'];
    materialStatus = json['materialStatus'];
    bloodGroup = json['bloodGroup'];
    job = json['job'];
    citizenship = json['citizenship'];
    validDate = json['validDate'];
    picture = json['picture'];
    profile =
        json['profile'] != null ? Profile.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fullName'] = fullName;
    data['birthDate'] = birthDate;
    data['birthPlace'] = birthPlace;
    data['gendre'] = gendre;
    data['address'] = address;
    data['rt'] = rt;
    data['rw'] = rw;
    data['district'] = district;
    data['subdistrict'] = subdistrict;
    data['province'] = province;
    data['religion'] = religion;
    data['materialStatus'] = materialStatus;
    data['bloodGroup'] = bloodGroup;
    data['job'] = job;
    data['citizenship'] = citizenship;
    data['validDate'] = validDate;
    data['picture'] = picture;
    if (profile != null) {
      data['profile'] = profile!.toJson();
    }
    return data;
  }
}
