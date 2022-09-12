class UserModel {
  String? id;
  String? name;
  String? email;
  String? avatar;

  UserModel({this.id, this.name, this.email, this.avatar});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'].toString(),
      name: json['first_name'] + " " + json['last_name'],
      email: json['email'],
      avatar: json['avatar'],
    );
  }
}
