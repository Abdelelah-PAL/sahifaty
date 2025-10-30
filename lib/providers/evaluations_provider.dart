import 'package:flutter/material.dart';
import 'package:sahifaty/models/evaluation.dart';
import 'package:sahifaty/services/evaluations_services.dart';

class EvaluationsProvider with ChangeNotifier {
  List<Evaluation> evaluations = [];
  bool isLoading = true;
  final EvaluationsServices _es = EvaluationsServices();

  Future<List<Evaluation?>> getAllCategories() async {
    var res = await _es.getAllEvaluations();
    evaluations = res;
    isLoading = false;
    notifyListeners();
    return evaluations;
  }
}
