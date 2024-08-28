import 'package:custom_chart/widgets/custom_bar_chart.dart';
import 'package:custom_chart/widgets/custom_line_chart.dart';
import 'package:flutter/material.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({super.key});

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  Map<String, dynamic> dataValue = {
    "Sunday": [5, 3, 1, 2, 0, 4],
    "Monday": [8, 8, 8, 3, 2, 10],
    "Tuesday": [1, 2, 6, 8, 0, 4],
    "Wednesday": [5, 8, 5, 30, 0, 0],
    "Thursday": [2, 0, 0, 0, 5, 0],
    "Friday": [5, 5, 9, 1, 4, 0],
    "Saturday": [2, 5, 11, 16, 23, 1],
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomBarChart(
                dataValue: dataValue,
                height: 100,
                width: 400,
                barColor: Colors.green,
              ),
              const SizedBox(
                height: 100,
              ),
              CustomLineChart(
                dataValue: dataValue,
                height: 100,
                width: 400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
