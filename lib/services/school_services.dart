import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sahifaty/services/sahifaty_api.dart';
import '../models/school.dart';

class SchoolServices {
  final _sahifatyApi = SahifatyApi();

  Future<School> getQuickQuestionsSchool() async {
    try {
      final http.Response res = await _sahifatyApi.get('schools/1');

      if (res.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(res.body);
        return School.fromJson(data);
      } else {
        throw Exception('Failed to load school data');
      }
    } catch (ex) {
      rethrow;
    }
  }
}
