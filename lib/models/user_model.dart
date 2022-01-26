User eventFromJson(dynamic json) => User.fromJson(json);

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.power,
  });

  int id;
  String name;
  String email;
  int power;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    name: json['name'],
    email: json['email'],
    power: json['power'],
  );
}
