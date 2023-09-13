import 'package:fl_pbi/models/user.dart';
import 'package:fl_pbi/screen/profile/data/identity_card.dart';
import 'package:jiffy/jiffy.dart';

class Profile {
  int? id;
  String? fullName;
  String? email;
  String? phone;
  String? currentAddress;
  String? createdAt;
  String? updatedAt;
  String? picture;
  User? user;
  String? birthDate;
  String? birthPlace;
  String? bloodGroup;
  String? gendre;
  String? religion;
  IdentityCard? identity;

  Profile({
    this.id,
    this.fullName,
    this.email,
    this.phone,
    this.currentAddress,
    this.createdAt,
    this.updatedAt,
    this.picture,
    this.user,
    this.identity,
    this.birthDate,
    this.birthPlace,
    this.bloodGroup,
    this.gendre,
    this.religion,
  });

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    email = json['email'];
    phone = json['phone'];
    currentAddress = json['currentAddress'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    picture = json['picture'];
    if (json['birthDate'].runtimeType == DateTime) {
      birthDate = Jiffy.parseFromDateTime(json['birthDate'])
          .format(pattern: "yyyy-MM-dd");
    } else {
      birthDate = json['birthDate'];
    }
    birthPlace = json['birthPlace'];
    bloodGroup = json['bloodGroup'];
    gendre = json['gendre'];
    religion = json['religion'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    identity = json['identity'] != null
        ? IdentityCard.fromJson(json['identity'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fullName'] = fullName;
    data['email'] = email;
    data['phone'] = phone;
    data['currentAddress'] = currentAddress;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['picture'] = picture;
    if (birthDate.runtimeType == String) {
      data['birthDate'] = DateTime.parse(birthDate ?? "");
    } else {
      data['birthDate'] = birthDate;
    }
    data['birthPlace'] = birthPlace;
    data['bloodGroup'] = bloodGroup;
    data['gendre'] = gendre;
    data['religion'] = religion;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (identity != null) {
      data['identity'] = identity!.toJson();
    }
    return data;
  }
}
