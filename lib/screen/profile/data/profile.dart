import 'package:fl_pbi/models/user.dart';

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
  String? idCardType;
  String? picture;
  User? user;

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
    this.idCardType,
    this.picture,
    this.user,
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
    idCardType = json['idCardType'];
    picture = json['picture'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['fullName'] = fullName;
    data['email'] = email;
    data['phone'] = phone;
    data['currentAddress'] = currentAddress;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['idCardType'] = idCardType;
    data['picture'] = picture;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
