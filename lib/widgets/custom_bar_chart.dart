import 'package:custom_chart/services/bar_function.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomBarChart extends StatelessWidget {
  final double height;
  final double width;
  final Map<String, dynamic> dataValue;
  final Color barColor;

  // Move ValueNotifier to a class-level final variable
  final ValueNotifier<List<int>> valueNotifier;

  CustomBarChart({
    super.key,
    required this.dataValue,
    required this.height,
    required this.width,
    this.barColor = Colors.indigo,
  }) : valueNotifier = ValueNotifier(dataValue[dataValue.keys.first]);

  @override
  Widget build(BuildContext context) {
    final bootomTileValue = dataValue.keys
        .map(
          (key) => key.substring(
            0,
            3,
          ),
        )
        .toList();
    final ValueNotifier<String> keyValue = ValueNotifier(bootomTileValue.first);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width / height * 10),
        color: barColor.withOpacity(0.1),
      ),
      width: width + 0.7 * width,
      child: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: height,
              width: width,
              child: AspectRatio(
                aspectRatio: height / width,
                child: ValueListenableBuilder(
                    valueListenable: valueNotifier,
                    builder: (context, value, child) {
                      return BarChart(
                        BarFunction().mainBarData(value, barColor),
                      );
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(bootomTileValue.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        keyValue.value = bootomTileValue[index];
                        // print(dataValue[dataValue.keys.toList()[index]]);
                        valueNotifier.value =
                            dataValue[dataValue.keys.toList()[index]];
                      },
                      child: ValueListenableBuilder(
                        valueListenable: keyValue,
                        builder: (context, value, child) {
                          return Text(bootomTileValue[index],
                              style: bootomTileValue[index] == value
                                  ? TextStyle(
                                      color: barColor,
                                      fontWeight: FontWeight.bold)
                                  : null);
                        },
                      ),
                    );
                  }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
