import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:frontend/utils/constant.dart';
import 'package:frontend/utils/custom_theme.dart';

class Linechart extends StatelessWidget {
  const Linechart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400,
      padding: Theme.of(context).subSectionDividerPadding,
      child: LineChart(
        LineChartData(
          minY: 0,
          maxY: 100,
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  const style = TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  );
                  switch (value.toInt()) {
                    case 0:
                      return Text('Sun', style: style);
                    case 1:
                      return Text('Mon', style: style);
                    case 2:
                      return Text('Tue', style: style);
                    case 3:
                      return Text('Wed', style: style);
                    case 4:
                      return Text('Thu', style: style);
                    case 5:
                      return Text('Fri', style: style);
                    case 6:
                      return Text('Sat', style: style);
                    default:
                      return Text('', style: style);
                  }
                },
                reservedSize: 30,
              ),
            ),
          ),
          gridData: FlGridData(show: true),
          lineBarsData: [
            LineChartBarData(
              spots: const [
                FlSpot(0, 20),
                FlSpot(1, 50),
                FlSpot(2, 55),
                FlSpot(3, 80),
                FlSpot(4, 90),
                FlSpot(5, 70),
                FlSpot(6, 70),
              ],
              isCurved: true,
              color: PRIMARY_COLOR,
              barWidth: 6,
              belowBarData: BarAreaData(
                show: true,
                color: PRIMARY_COLOR.withOpacity(0.2),
              ),
              dotData: const FlDotData(
                show: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
