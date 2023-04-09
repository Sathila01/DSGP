class UserModel {
  String? uid, id;
  String? name;
  late String email, gender;
  String? password;
  String? regDate;

  UserModel(
      {this.id,
      this.uid,
      required this.email,
      required this.gender,
      this.name,
      this.regDate});

  Map toMap() {
    Map<String, dynamic> map = {};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    return map;
  }

  toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "gender": gender,
      "regDate": regDate,
    };
  }

  static UserModel fromJson(Map json) => UserModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      gender: json['gender']);

  UserModel.fromMap(Map map) {
    id = map['id'];
    name = map['name'];
    email = map['email'];
  }

  String? getID() {
    return id;
  }
}
