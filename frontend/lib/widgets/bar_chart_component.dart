import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:frontend/utils/constant.dart';

class BarChartComponent extends StatelessWidget {
  final Map<String, dynamic> data;

  const BarChartComponent({required this.data});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        gridData: const FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        maxY: 20,
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) => Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            final days = data.keys.toList().reversed.toList();
            return BarTooltipItem(
              data[days[groupIndex]].toString(),
              const TextStyle(
                color: PRIMARY_COLOR,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: PRIMARY_COLOR,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    final days = data.keys.toList().reversed.toList();
    String text = days[value.toInt()];

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  LinearGradient get _barsGradient => LinearGradient(
        colors: [PRIMARY_COLOR, PRIMARY_COLOR.withOpacity(0.4)],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  List<BarChartGroupData> get barGroups {
    List<BarChartGroupData> groups = [];
    final days = data.keys.toList().reversed.toList();

    final maxValue = data.values.isNotEmpty
        ? data.values.reduce((a, b) => a > b ? a : b)
        : 0;
    final minValue = data.values.isNotEmpty
        ? data.values.reduce((a, b) => a < b ? a : b)
        : 0;

    for (int i = 0; i < days.length; i++) {
      double rawValue = (data[days[i]] ?? 0).toDouble();
      double normalizedValue = maxValue == minValue
          ? 0
          : (rawValue - minValue) / (maxValue - minValue) * 20;

      groups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: normalizedValue,
              gradient: _barsGradient,
              rodStackItems: [
                BarChartRodStackItem(0, normalizedValue, Colors.transparent),
              ],
            )
          ],
          showingTooltipIndicators: [0],
        ),
      );
    }

    return groups;
  }
}
