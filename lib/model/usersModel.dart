class UsersModel {
  int? id;
  String? username;
  String? password;

  UsersModel({this.username, this.password});

  factory UsersModel.fromJSON(Map<String, dynamic> json) {
    return UsersModel(username: json['username'], password: json['password']);
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}
