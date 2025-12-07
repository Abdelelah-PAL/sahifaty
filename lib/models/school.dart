class School {
  int? _id;
  String schoolName;
  List<Map<String, dynamic>> levels;

  School({
    int? id,
    required this.schoolName,
    required this.levels,
  }) : _id = id;

  int? get id => _id;

  // Corrected fromJson
  factory School.fromJson(Map<String, dynamic> json) {
    return School(
      id: json['_id'],
      schoolName: json['schoolName'],
      levels: json['levels'] != null
          ? List<Map<String, dynamic>>.from(
        json['levels'].map((level) => Map<String, dynamic>.from(level)),
      )
          : [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': _id,
      'schoolName': schoolName,
      'levels': levels,
    };
  }
}
