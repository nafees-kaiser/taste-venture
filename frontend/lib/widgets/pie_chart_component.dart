import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:frontend/utils/constant.dart';
import 'package:frontend/widgets/indicator.dart';

class PieChartComponent extends StatefulWidget {
  const PieChartComponent({super.key});

  @override
  State<StatefulWidget> createState() => _PieChartComponent();
}

class _PieChartComponent extends State {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.4,
      child: Row(
        children: <Widget>[
          const SizedBox(
            height: 18,
          ),
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
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: showingSections(),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Indicator(
                color: PRIMARY_COLOR.withOpacity(0.2),
                text: 'Indian',
                isSquare: true,
              ),
              SizedBox(
                height: 4,
              ),
              Indicator(
                color: PRIMARY_COLOR.withOpacity(0.4),
                text: 'Japanese',
                isSquare: true,
              ),
              SizedBox(
                height: 4,
              ),
              Indicator(
                color: PRIMARY_COLOR.withOpacity(0.6),
                text: 'Thai',
                isSquare: true,
              ),
              SizedBox(
                height: 4,
              ),
              Indicator(
                color: PRIMARY_COLOR.withOpacity(0.8),
                text: 'Western',
                isSquare: true,
              ),
              SizedBox(
                height: 18,
              ),
            ],
          ),
          const SizedBox(
            width: 28,
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: PRIMARY_COLOR.withOpacity(0.2),
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: PRIMARY_COLOR.withOpacity(0.2),
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: PRIMARY_COLOR.withOpacity(0.4),
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: PRIMARY_COLOR.withOpacity(0.4),
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: PRIMARY_COLOR.withOpacity(0.6),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: PRIMARY_COLOR.withOpacity(0.6),
              shadows: shadows,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: PRIMARY_COLOR.withOpacity(0.8),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: PRIMARY_COLOR.withOpacity(0.8),
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}
