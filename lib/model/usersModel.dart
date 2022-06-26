class UsersModel {
  String email;
  String password;

  UsersModel({required this.email, required this.password});

  factory UsersModel.fromJSON(Map<String, dynamic> json) {
    return UsersModel(email: json['email'], password: json['password']);
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{
      'email': email,
      'password': password,
    };

    return map;
  }
}
