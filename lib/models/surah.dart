class User {
  String? _id;
  String? nameAr;
  String? ayahCount;


  User({
    String? id,
    this.nameAr,
    this.ayahCount,
  }) : _id = id;

  String? get id => _id;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      nameAr: json['nameAr'],
      ayahCount: json['ayahCount'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': _id,
      'nameAr': nameAr,
      'ayahCount': ayahCount,
    };
  }
}
