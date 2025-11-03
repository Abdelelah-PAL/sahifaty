import 'dart:core';
import 'package:sahifaty/models/evaluation.dart';
import 'package:sahifaty/services/sahifaty_api.dart';

class EvaluationsServices {
  final SahifatyApi _sahifatyApi = SahifatyApi();

  Future<List<Evaluation>> getAllEvaluations() async {
    try {
      var evaluations = await _sahifatyApi.get('evaluations');
      if (evaluations != null && evaluations is List) {
        return evaluations
            .map<Evaluation>((evaluation) => Evaluation.fromJson(evaluation))
            .toList();
      } else {
        return [];
      }
    } catch (ex) {
      rethrow;
    }
  }
}
