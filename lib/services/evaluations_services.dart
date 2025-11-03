import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:sahifaty/models/evaluation.dart';
import 'package:sahifaty/services/sahifaty_api.dart';

class EvaluationsServices {
  final SahifatyApi _sahifatyApi = SahifatyApi();

  Future<List<Evaluation>> getAllEvaluations() async {
    try {
      final http.Response res = await _sahifatyApi.get('evaluations');

      if (res.statusCode == 200) {
        final List<dynamic> data = jsonDecode(res.body);

        // Map each item to Evaluation model
        return data.map<Evaluation>((e) => Evaluation.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load evaluations');
      }
    } catch (ex) {
      rethrow;
    }
  }

  Future<http.Response> evaluateAyah(Map<String, dynamic> body) async {
    try {
      print(body);
      http.Response response =
          await _sahifatyApi.post(url: 'user-evaluations', body: body);
      print(response.body);
      return response;
    } catch (ex) {
      rethrow;
    }
  }
}
