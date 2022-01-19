class AuthModel {
  String? email;
  String? password;
  String? token;
  int? id;
  String? name;
  int? power;

  AuthModel(
    this.email,
    this.password,
  );

  setCredentials(email, password) {
    email;
    password;
  }

  setToken(token) {
    token;
  }

  fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    power = json['power'];
  }
}
