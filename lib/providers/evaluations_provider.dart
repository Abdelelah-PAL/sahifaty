import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:sahifaty/models/evaluation.dart';
import 'package:sahifaty/models/user_evaluation.dart';
import 'package:sahifaty/services/evaluations_services.dart';

import '../models/chart_evaluation_data.dart';

class EvaluationsProvider with ChangeNotifier {
  List<Evaluation> evaluations = [];
  List<UserEvaluation> userEvaluations = [];
  List<ChartEvaluationData> chartEvaluationData = [];
  bool isLoading = true;
  int totalCount = 0;
  final EvaluationsServices _evaluationsServices = EvaluationsServices();

  Future<List<Evaluation?>> getAllEvaluations() async {
    setLoading();
    evaluations = await _evaluationsServices.getAllEvaluations();
    resetLoading();
    return evaluations;
  }

  Future<http.Response> evaluateAyah(Map<String, dynamic> body) async {
    try {
      setLoading();
      http.Response response = await _evaluationsServices.evaluateAyah(body);
      resetLoading();
      return response;
    } catch (ex) {
      rethrow;
    } finally {
      resetLoading();
    }
  }

  Future<http.Response> evaluateMultipleAyat(Map<String, dynamic> body) async {
    try {

      setLoading();
      http.Response response = await _evaluationsServices.evaluateMultipleAyat(body);
      resetLoading();
      return response;
    } catch (ex) {
      rethrow;
    } finally {
      resetLoading();
    }
  }


  Future<void> getQuranChartData(int userId) async {
    try {
      setLoading();
      final response = await _evaluationsServices.getQuranChartData(userId);

      totalCount = response['total'];
      chartEvaluationData = (response['evaluations'] as List)
          .map<ChartEvaluationData>((e) => ChartEvaluationData.fromJson(e))
          .toList();
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching chart data: $e");
      }
      rethrow;
    } finally {
      resetLoading();
    }
  }

  Future<void> getAllUserEvaluations(int userId, List<int> ayatIds) async {
    userEvaluations.clear();
    setLoading();
    userEvaluations =
        await _evaluationsServices.getAllUserEvaluations(userId, ayatIds);
    resetLoading();
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
