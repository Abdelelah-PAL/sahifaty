class User {
  int id;
  String fullName;
  String email;
  String? password;
  int? userRoleId;


  User({
    required this.id,
    required this.fullName,
    required this.email,
    this.password,
    this.userRoleId,
  });


  // from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      password: json['password'],
      userRoleId: json['userRoleId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'password': password,
      'userRoleId': userRoleId,
    };
  }

  @override
  String toString() {
    return 'AuthData(id: $id, fullName: $fullName, email: $email, password: $password, userRoleId: $userRoleId)';
  }
}
