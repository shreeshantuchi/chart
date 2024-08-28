import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineFunction {
  LineChartData sampleData1(List<int> data, {Color color = Colors.pink}) =>
      LineChartData(
        // lineTouchData: lineTouchData1,
        gridData: const FlGridData(show: false),
        titlesData: const FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        lineBarsData: lineBarsData(data, color),
        minX: -1,
        maxX: data.length.toDouble(),
        maxY: data.reduce((a, b) => a > b ? a : b).toDouble(),
        minY: 0,
      );
  List<LineChartBarData> lineBarsData(List<int> data, Color color) =>
      [lineChartBarData(data, color)];

  LineChartBarData lineChartBarData(List<int> data, Color color) =>
      LineChartBarData(
        curveSmoothness: 0.4,
        isCurved: true,
        color: color,
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: List.generate(
          data.length,
          (index) => FlSpot(
            index.toDouble(),
            data[index].toDouble(),
          ),
        ),
      );
}
