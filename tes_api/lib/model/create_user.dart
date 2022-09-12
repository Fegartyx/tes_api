class CreateUser {
  String? id;
  String? name;
  String? job;
  String? createdAt;

  CreateUser({this.name, this.job, this.id, this.createdAt});

  factory CreateUser.fromJson(Map<String, dynamic> json) {
    return CreateUser(
        name: json['name'],
        job: json['job'],
        id: json['id'],
        createdAt: json['createdAt']);
  }

  Map<String, dynamic> toJson() => {'name': name, 'job': job};
}
