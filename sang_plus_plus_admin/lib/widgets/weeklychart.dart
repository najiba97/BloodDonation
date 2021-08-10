import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sang_plus_plus_admin/services/database.dart';

class WeeklyChart extends StatelessWidget {
  const WeeklyChart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<DocumentSnapshot>.value(
      initialData: null,
      value: AdminMedcinData().statis,
      builder: (context, child) {
        getBarGroups() {
          final gs = Provider.of<DocumentSnapshot>(context);
          List<double> barChartData = [
            double.parse(gs['A+'].toString()),
            double.parse(gs['A-'].toString()),
            double.parse(gs['AB+'].toString()),
            double.parse(gs['AB-'].toString()),
            double.parse(gs['B+'].toString()),
            double.parse(gs['B-'].toString()),
            double.parse(gs['O+'].toString()),
            double.parse(gs['O-'].toString()),
          ];
          List<BarChartGroupData> barChartGroup = [];
          barChartData.asMap().forEach(
              (i, value) => barChartGroup.add(BarChartGroupData(x: i, barRods: [
                    BarChartRodData(
                        y: value,
                        width: 15,
                        colors: i % 2 == 0 ? [Colors.indigo[900]] : null)
                  ])));
          return barChartGroup;
        }

        String getWeek(double value) {
          switch (value.toInt()) {
            case 0:
              return 'A+';
            case 1:
              return 'A-';
            case 2:
              return 'AB+';
            case 3:
              return 'AB-';
            case 4:
              return 'B+';
            case 5:
              return 'B-';
            case 6:
              return 'O+';
            case 7:
              return 'O-';
              break;
            default:
              return '';
          }
        }

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
      },
    );
  }
}
