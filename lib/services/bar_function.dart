import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarFunction {
  List<BarChartGroupData> getGroupData(
    List<int> barData,
    Color color,
  ) {
    int count = 0;
    final barCharGroupDataList = barData.map((e) {
      final data = _makeGroupData(
        barColor: color,
        barData.reduce((a, b) => a > b ? a : b).toDouble(),
        count,
        e.toDouble(),
      );
      count++;
      return data;
    }).toList();
    return barCharGroupDataList;
  }

  BarChartGroupData _makeGroupData(
    double max,
    int x,
    double y, {
    Color? barColor,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: barColor,
          width: width,
          borderSide: const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: max,
            color: barColor!.withOpacity(0.2),
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  BarChartData mainBarData(List<int> data, Color color) {
    return BarChartData(
        titlesData: const FlTitlesData(show: false),
        barGroups: getGroupData(data, color),
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false));
  }
}
