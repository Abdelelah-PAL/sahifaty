class User {
  int? id;
  String username;
  String login;
  String email;
  String? password;
  int? roleNum;

  User({
    this.id,
    required this.username,
    required this.login,
    required this.email,
    this.password,
    this.roleNum,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        username: json['username'],
        login: json['login'],
        email: json['email'],
        password: json['password'],
        roleNum: json['roleNum']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'login': login,
      'email': email,
      'password': password,
      'roleNum': roleNum,
    };
  }
}
