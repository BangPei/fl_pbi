class Login {
  int? id;
  String? username;
  String? password;
  String? firstName;

  Login({
    this.id,
    this.username,
    this.password,
    this.firstName,
  });

  Login.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    password = json['password'];
    firstName = json['firstName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['userName'] = username;
    data['password'] = password;
    data['firstName'] = firstName;
    return data;
  }
}
