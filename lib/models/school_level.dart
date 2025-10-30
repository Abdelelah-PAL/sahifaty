class SchoolLevel {
  String? _id;
  String schoolId;
  String schoolName;
  int level;


  SchoolLevel({
    String? id,
    required this.schoolId,
    required this.schoolName,
    required this.level,
  }) : _id = id;

  String? get id => _id;

  factory SchoolLevel.fromJson(Map<String, dynamic> json) {
    return SchoolLevel(
      id: json['_id'],
      schoolId: json['schoolId'],
      schoolName: json['schoolName'],
      level: json['level'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': _id,
      'schoolId': schoolId,
      'schoolName': schoolName,
      'level': level,
    };
  }
}
