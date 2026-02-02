import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sahifaty/models/evaluation.dart';
import 'package:sahifaty/providers/ayat_provider.dart';
import 'package:sahifaty/providers/evaluations_provider.dart';
import 'package:http/http.dart' as http;
import '../core/constants/colors.dart';
import '../models/ayat.dart';
import '../models/chart_evaluation_data.dart';
import '../models/user_evaluation.dart';

import 'package:get/get.dart';

class EvaluationsController {
  static final EvaluationsController _instance =
      EvaluationsController._internal();

  String getLocalizedName(int? id) {
    if (id == null) return '';
    return 'eval_$id'.tr;
  }

  factory EvaluationsController() => _instance;

  EvaluationsController._internal();

  Future<void> sendEvaluation(
      Ayat verse,
      Evaluation evaluation,
      EvaluationsProvider evaluationsProvider,
      AyatProvider? ayatProvider) async {
    try {
      final Map<String, dynamic> userEvaluation = UserEvaluation(
        ayahId: verse.id!,
        evaluationId: evaluation.id!,
        comment: '',
      ).toMap();

      final http.Response response =
          await evaluationsProvider.evaluateAyah(userEvaluation);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Fluttertoast.showToast(
          msg: 'eval_success_verse'.tr,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        // increment evaluated verses if coming from questions screen
        // if(ayatProvider != null) {
        //   ayatProvider.incrementEvaluatedVersesCount();
        // }
      } else {
        await evaluationsProvider.evaluateAyah(userEvaluation);

        Fluttertoast.showToast(
          msg: 'eval_error'.tr,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (error) {
      Fluttertoast.showToast(
        msg: 'generic_error'.tr,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<void> sendMultipleEvaluations(
      List<Ayat> verses,
      Evaluation evaluation,
      EvaluationsProvider evaluationsProvider,
      AyatProvider? ayatProvider,
      String unitName) async {
    try {
      final ayatIds = verses.map((v) => v.id!).toList();
      final Map<String, dynamic> userEvaluation = UserEvaluation(
        ayahIds: ayatIds,
        evaluationId: evaluation.id!,
        comment: '',
      ).toMap();

      final http.Response response =
          await evaluationsProvider.evaluateMultipleAyat(userEvaluation);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Fluttertoast.showToast(
          msg: 'eval_success_unit'.trParams({'unit': unitName}),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        // increment evaluated verses if coming from questions screen
        // if(ayatProvider != null) {
        //   ayatProvider.incrementEvaluatedVersesCount();
        // }
      } else {
        Fluttertoast.showToast(
          msg: 'eval_error'.tr,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (error) {
      Fluttertoast.showToast(
        msg: 'generic_error'.tr,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      rethrow;
    }
  }

  ChartEvaluationData? getEvaluationById(
      int id, EvaluationsProvider evaluationsProvider) {
    try {
      return evaluationsProvider.chartEvaluationData.firstWhere(
        (e) => e.evaluationId == id,
      );
    } catch (e) {
      return null;
    }
  }

  List<PieChartSectionData> buildChartSections(EvaluationsProvider provider) {
    return provider.chartEvaluationData.map((evaluation) {
      final double value = evaluation.percentage?.toDouble() ?? 0;
      final double adjustedValue = value < 2.0 ? 2.0 : value;

      // Adjust font size dynamically based on the percentage
      double fontSize;
      // Dynamically calculate font size based on percentage
      // Scaling factor of 2.5 seems appropriate given the radius of 150
      fontSize = (value * 2.5).clamp(5.0, 18.0);

      return PieChartSectionData(
        color: EvaluationsController()
            .getColorForEvaluation(evaluation.evaluationId),
        value: adjustedValue,
        title: '${evaluation.percentage?.toStringAsFixed(2)}%',
        radius: 150,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }

  Color getColorForEvaluation(int? evaluationId) {
    switch (evaluationId) {
      case 0:
        return AppColors.uncategorizedColor; // غير مصنف
      case 1:
        return AppColors.strongColor; // متمكن
      case 2:
        return AppColors.revisionColor; // مراجعة
      case 3:
        return AppColors.desireColor; // للحفظ
      case 4:
        return AppColors.easyColor; // سهل
      case 5:
        return AppColors.hardColor; // صعب
      default:
        return Colors.grey.shade400; // fallback color
    }
  }
}
