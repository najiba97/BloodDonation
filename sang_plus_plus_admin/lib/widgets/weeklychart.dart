import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WeeklyChart extends StatelessWidget {
  const WeeklyChart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 1.5,
        child: BarChart(BarChartData(
          barGroups: getBarGroups(),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            leftTitles: SideTitles(
              showTitles: false,
            ),
            bottomTitles: SideTitles(
              showTitles: true,
              getTitles: getWeek,
            ),
          ),
        )));
  }
}

getBarGroups() {
  List<double> barChartData = [
    6,
    10,
    8,
    7,
    10,
    15,
    9,
  ];
  List<BarChartGroupData> barChartGroup = [];
  barChartData.asMap().forEach(
      (i, value) => barChartGroup.add(BarChartGroupData(x: i, barRods: [
            BarChartRodData(
                y: value,
                width: 15,
                colors: i == 4 ? [Colors.indigo[900]] : null)
          ])));
  return barChartGroup;
}

String getWeek(double value) {
  switch (value.toInt()) {
    case 0:
      return 'lu';
    case 1:
      return 'ma';
    case 2:
      return 'me';
    case 3:
      return 'je';
    case 4:
      return 've';
    case 5:
      return 'sa';
    case 6:
      return 'di';
      break;
    default:
      return '';
  }
}
