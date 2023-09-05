class Login {
  int? id;
  String? username;
  String? password;

  Login({
    this.id,
    this.username,
    this.password,
  });

  Login.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['username'] = username;
    data['password'] = password;
    return data;
  }
}
