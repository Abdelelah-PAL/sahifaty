import 'package:flutter/material.dart';
import 'package:pie_chart_3d/pie_chart_3d.dart';

import '../../controllers/general_controller.dart';
class PieChart3D extends StatelessWidget {
  const PieChart3D({super.key, required this.strongValue, required this.revisionValue, required this.desireValue, required this.easyValue, required this.hardValue, required this.uncategorizedValue});
  final double strongValue;
  final double revisionValue;
  final double desireValue;
  final double easyValue;
  final double hardValue;
  final double uncategorizedValue;

  @override
  Widget build(BuildContext context) {
    return  ThreeDPieChart(
      data: [
        ChartData(
            category: '',
            value: strongValue,
            color: GeneralController().dropdownOptions[0]['color']),
        ChartData(
            category:'',
            value: revisionValue,
            color: GeneralController().dropdownOptions[1]['color']),
        ChartData(
            category:'',
            value: desireValue,
            color: GeneralController().dropdownOptions[2]['color']),
        ChartData(
            category: '',
            value: easyValue,
            color: GeneralController().dropdownOptions[3]['color']),
        ChartData(
            category: '',
            value: hardValue,
            color: GeneralController().dropdownOptions[4]['color']),
        ChartData(
            category: '',
            value: uncategorizedValue,
            color: GeneralController().dropdownOptions[5]['color']),
      ],
      options: PieChartOptions(
        height: 250,
        width: 250,
        radius: 0.6,
        depthDarkness: 3.5,
        ellipseRatio: 0.7,
        showLabels: false,
      ),
    );
  }
}
