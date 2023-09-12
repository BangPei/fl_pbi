import 'package:fl_pbi/models/user.dart';
import 'package:fl_pbi/screen/profile/data/identity_card.dart';

class Profile {
  int? id;
  String? firstName;
  String? lastName;
  String? fullName;
  String? email;
  String? phone;
  String? currentAddress;
  String? createdAt;
  String? updatedAt;
  String? picture;
  User? user;
  List<IdentityCard>? identities;

  Profile({
    this.id,
    this.firstName,
    this.lastName,
    this.fullName,
    this.email,
    this.phone,
    this.currentAddress,
    this.createdAt,
    this.updatedAt,
    this.picture,
    this.user,
    this.identities,
  });

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    fullName = json['fullName'];
    email = json['email'];
    phone = json['phone'];
    currentAddress = json['currentAddress'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    picture = json['picture'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['identities'] != null) {
      identities = <IdentityCard>[];
      json['identities'].forEach((v) {
        identities!.add(IdentityCard.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['fullName'] = (lastName == null || lastName == "")
        ? firstName
        : '$firstName $lastName';
    data['email'] = email;
    data['phone'] = phone;
    data['currentAddress'] = currentAddress;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['picture'] = picture;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (identities != null) {
      data['identities'] = identities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
