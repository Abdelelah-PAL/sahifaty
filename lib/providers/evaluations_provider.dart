import 'package:flutter/material.dart';
import 'package:sahifaty/models/evaluation.dart';
import 'package:sahifaty/services/evaluations_services.dart';

class EvaluationsProvider with ChangeNotifier {
  List<Evaluation> evaluations = [];
  bool isLoading = true;
  final EvaluationsServices _evaluationsServices = EvaluationsServices();

  Future<List<Evaluation?>> getAllEvaluations() async {
    setLoading();
    evaluations = await _evaluationsServices.getAllEvaluations();
    resetLoading();
    return evaluations;
  }

  void setLoading() {
    isLoading = true;
    notifyListeners();
  }

  void resetLoading() {
    isLoading = false;
    notifyListeners();
  }


}
