import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class EfficiencyChart extends StatelessWidget {
  const EfficiencyChart({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: LineChart(LineChartData(
        maxX: 7,
        minX: 1,
        minY: 0,
        maxY: 10,
        gridData: FlGridData(
            show: true,
            drawHorizontalLine: false,
            drawVerticalLine: true,
            verticalInterval: 1),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 15,
                  interval: 1,
                  getTitlesWidget: (value, meta) {
                    String text = '';
                    switch (value.toInt()) {
                      case 1:
                        text = 'Mon';
                        break;
                      case 3:
                        text = 'Wed';
                        break;
                      case 5:
                        text = 'Fri';
                        break;
                      case 7:
                        text = 'Sun';
                        break;
                    }

                    return Text(
                      text,
                      style:
                          TextStyle(color: Color.fromARGB(150, 255, 255, 255)),
                    );
                  })),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
              color: Color.fromARGB(255, 176, 255, 217),
              //isCurved: true,
              spots: [
                FlSpot(1, 2),
                FlSpot(2, 5),
                FlSpot(3, 4),
                FlSpot(4, 6.7),
                FlSpot(5, 7),
                FlSpot(6, 5),
                FlSpot(7, 9.8)
              ],
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(show: true))
        ],
      )),
    );
  }
}
