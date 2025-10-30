import 'dart:convert';
import 'dart:core';

import 'package:sahifaty/models/evaluation.dart';
import 'package:sahifaty/services/sahifaty_api.dart';

class EvaluationsServices {
  final SahifatyApi _sahifatyApi = SahifatyApi();

  Future<List<Evaluation>> getAllEvaluations() async {
    try {
      final evaluations = await _sahifatyApi.get('evaluations');

      if (evaluations != null) {
        return (evaluations as List)
            .map((e) => Evaluation.fromJson(e))
            .toList();
      } else {
        return [];
      }
    } catch (ex) {
      rethrow;
    }
  }
}
