import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pie_chart_3d/pie_chart_3d.dart';
import '../../controllers/general_controller.dart';

class PieChart3D extends StatefulWidget {
  const PieChart3D({
    super.key,
    required this.strongValue,
    required this.revisionValue,
    required this.desireValue,
    required this.easyValue,
    required this.hardValue,
    required this.uncategorizedValue,
  });

  final double strongValue;
  final double revisionValue;
  final double desireValue;
  final double easyValue;
  final double hardValue;
  final double uncategorizedValue;

  @override
  State<PieChart3D> createState() => _PieChart3DState();
}

class _PieChart3DState extends State<PieChart3D> {
  int? selectedSlice;

  @override
  Widget build(BuildContext context) {
    final data = [
      ChartData(
          category: 'Strong',
          value: widget.strongValue,
          color: GeneralController().dropdownOptions[0]['color']),
      ChartData(
          category: 'Revision',
          value: widget.revisionValue,
          color: GeneralController().dropdownOptions[1]['color']),
      ChartData(
          category: 'Desire',
          value: widget.desireValue,
          color: GeneralController().dropdownOptions[2]['color']),
      ChartData(
          category: 'Easy',
          value: widget.easyValue,
          color: GeneralController().dropdownOptions[3]['color']),
      ChartData(
          category: 'Hard',
          value: widget.hardValue,
          color: GeneralController().dropdownOptions[4]['color']),
      ChartData(
          category: 'Uncategorized',
          value: widget.uncategorizedValue,
          color: GeneralController().dropdownOptions[5]['color']),
    ];

    return GestureDetector(
      onTapDown: (details) {
        final box = context.findRenderObject() as RenderBox;
        final offset = box.globalToLocal(details.globalPosition);
        final center = Offset(box.size.width / 2, box.size.height / 2);
        final dx = offset.dx - center.dx;
        final dy = offset.dy - center.dy;

        double angle = atan2(dy, dx);
        if (angle < -pi / 2) {
          angle += 2 * pi; // normalize
        }

        // Calculate which slice was tapped
        final total = data.fold(0.0, (sum, item) => sum + item.value);
        double currentAngle = -pi / 2;
        for (int i = 0; i < data.length; i++) {
          double sweep = (data[i].value / total) * 2 * pi;
          if (angle >= currentAngle && angle <= currentAngle + sweep) {
            setState(() {
              selectedSlice = i;
            });
            break;
          }
          currentAngle += sweep;
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          ThreeDPieChart(
            data: data,
            options: PieChartOptions(
              height: 250,
              width: 250,
              radius: 0.6,
              depthDarkness: 3.5,
              ellipseRatio: 0.7,
              showLabels: false,
            ),
          ),
          if (selectedSlice != null)
            Positioned(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(
                    red: 0,
                    green: 0,
                    blue: 0,
                    alpha: 0.7 * 255,
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  data[selectedSlice!].category,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
        ],
      ),
    );
  }
}