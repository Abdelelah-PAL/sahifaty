class User {
  String? _id;
  String? username;
  String? email;
  String? password;
  int? roleNum;


  User({
    String? id,
    this.username,
    this.email,
    this.password,
    this.roleNum,
  }) : _id = id;

  String? get id => _id;

  // from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      roleNum: json['roleNum'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': _id, // keep consistent with JSON
      'username': username,
      'email': email,
      'password': password,
      'roleNum': roleNum,
    };
  }
}
