import 'package:sahifaty/models/school_level.dart';

class School {
  int? _id;
  String schoolName;
  List<SchoolLevel> levels;

  School({
    int? id,
    required this.schoolName,
    required this.levels,
  }) : _id = id;

  int? get id => _id;

  factory School.fromJson(Map<String, dynamic> json) {
    return School(
      id: json['_id'],
      schoolName: json['schoolName'],
      levels: json['levels'] != null
          ? (json['levels'] as List)
          .map((e) => SchoolLevel.fromJson(e))
          .toList()
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
