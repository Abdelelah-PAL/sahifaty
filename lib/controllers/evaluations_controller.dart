import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sahifaty/models/evaluation.dart';
import 'package:sahifaty/providers/evaluations_provider.dart';
import 'package:http/http.dart' as http;
import '../models/ayat.dart';
import '../models/user_evaluation.dart';

class EvaluationsController {
  static final EvaluationsController _instance =
      EvaluationsController._internal();

  factory EvaluationsController() => _instance;

  EvaluationsController._internal();

  Future<void> sendEvaluation(
    Ayat verse,
    Evaluation evaluation,
    EvaluationsProvider evaluationsProvider,
  ) async {
    try {
      final Map<String, dynamic> userEvaluation = UserEvaluation(
        ayahId: verse.id!,
        evaluationId: evaluation.id!,
        comment: '',
      ).toMap();

      final http.Response response =
          await evaluationsProvider.evaluateAyah(userEvaluation);

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: 'Evaluation submitted successfully!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        Fluttertoast.showToast(
          msg: 'Failed to submit evaluation.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (error) {
      Fluttertoast.showToast(
        msg: 'Something went wrong. Please try again.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}
