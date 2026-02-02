import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sahifaty/providers/evaluations_provider.dart';
import '../../controllers/evaluations_controller.dart';
import '../../controllers/general_controller.dart';

class BarChartWidget extends StatelessWidget {
  const BarChartWidget({
    super.key,
    required this.evaluationsProvider,
  });

  final EvaluationsProvider evaluationsProvider;

  @override
  Widget build(BuildContext context) {
    final evaluationsController = EvaluationsController();
    final generalController = GeneralController();

    final List<BarChartGroupData> barGroups = [];
    double maxY = 0;

    for (int i = 0; i < generalController.dropdownOptions.length; i++) {
      final evaluation = evaluationsController.getEvaluationById(
          i, evaluationsProvider);

      if (evaluation == null) continue;

      final value = evaluation.percentage?.toDouble() ?? 0;
      if (value > maxY) maxY = value;

      final color = generalController.dropdownOptions[i]['color'] as Color;

      barGroups.add(
        BarChartGroupData(
          x: i,
          showingTooltipIndicators: [0],
          barRods: [
            BarChartRodData(
              toY: value,
              color: color,
              width: 16,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
            ),
          ],
        ),
      );
    }

    return AspectRatio(
      aspectRatio: 0.7,
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: RotatedBox(
          quarterTurns: 3,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: 100,
              barTouchData: BarTouchData(
                enabled: false,
                touchTooltipData: BarTouchTooltipData(
                  getTooltipColor: (_) => Colors.transparent,
                  tooltipPadding: EdgeInsets.zero,
                  tooltipMargin: 8,
                  rotateAngle: 90,
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    final evaluation = evaluationsController.getEvaluationById(
                        group.x, evaluationsProvider);
                    return BarTooltipItem(
                      // '',
                      '${rod.toY.toStringAsFixed(1)}%\n',
                      const TextStyle(
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      children: [
                        TextSpan(
                          text: '${evaluation?.count} آية',
                          style: const TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (double value, TitleMeta meta) {
                      final evaluation = evaluationsController.getEvaluationById(
                          value.toInt(), evaluationsProvider);
                      return SideTitleWidget(
                        meta: meta,
                        child: RotatedBox(
                          quarterTurns: 1,
                          child: Text(
                            evaluationsController.getLocalizedName(evaluation?.evaluationId),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      );
                    },
                    reservedSize: 60, // Adjust as needed for label height
                  ),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                leftTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),

                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              gridData: FlGridData(
                show: true,
                checkToShowHorizontalLine: (value) => value % 20 == 0,
                getDrawingHorizontalLine: (value) => FlLine(
                  color: Colors.grey.withOpacity(0.2),
                  strokeWidth: 1,
                ),
                drawVerticalLine: false,
              ),
              borderData: FlBorderData(
                show: true,
                border: const Border(
                  top: BorderSide.none,
                  bottom: BorderSide(
                      color: Colors.black, width: 1),
                  left: BorderSide(
                      color: Colors.black, width: 1),
                  right: BorderSide.none,
                ),
              ),
              barGroups: barGroups,
            ),
          ),
        ),
      ),
    );
  }
}
