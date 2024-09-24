import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:frontend/utils/constant.dart';
import 'package:frontend/widgets/indicator.dart';

class PieChartComponent extends StatefulWidget {
  final Map<String, dynamic> data;
  const PieChartComponent({required this.data, super.key});

  @override
  State<StatefulWidget> createState() => _PieChartComponent();
}

class _PieChartComponent extends State<PieChartComponent> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.4,
      child: Row(
        children: <Widget>[
          const SizedBox(height: 18),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: showingSections(),
                ),
              ),
            ),
          ),
          _buildIndicators(),
          const SizedBox(width: 28),
        ],
      ),
    );
  }

  Widget _buildIndicators() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.data.entries.map((entry) {
        return Indicator(
          color: PRIMARY_COLOR
              .withOpacity(0.2 + (0.2 * entry.value['percentage'] / 100)),
          text: entry.key,
          isSquare: true,
        );
      }).toList(),
    );
  }

  List<PieChartSectionData> showingSections() {
    return widget.data.entries.map((entry) {
      final isTouched =
          widget.data.keys.toList().indexOf(entry.key) == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      return PieChartSectionData(
        color: PRIMARY_COLOR
            .withOpacity(0.2 + (0.2 * entry.value['percentage'] / 100)),
        value: entry.value['percentage'],
        title: '${entry.value['percentage'].toStringAsFixed(0)}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: PRIMARY_COLOR
              .withOpacity(0.2 + (0.2 * entry.value['percentage'] / 100)),
          shadows: shadows,
        ),
      );
    }).toList();
  }
}
