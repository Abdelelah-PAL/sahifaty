import 'package:sahifaty/models/school_level_content.dart';

class SchoolLevel {
  String? _id;
  int? schoolId;
  String? schoolName;
  String? name;
  List<SchoolLevelContent> content;

  SchoolLevel({
    String? id,
    this.schoolId,
    this.name,
    this.schoolName,
    required this.content,
  }) : _id = id;

  String? get id => _id;

  factory SchoolLevel.fromJson(Map<String, dynamic> json) {
    return SchoolLevel(
      id: json['_id'],
      name: json['name'],
      content: json['content'] != null
          ? (json['content'] as List)
              .map((e) => SchoolLevelContent.fromJson(e))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': _id,
      'name': name,
      'content': content,
    };
  }
}
