import 'package:custom_chart/services/line_function.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomLineChart extends StatelessWidget {
  final double height;
  final double width;
  final Map<String, dynamic> dataValue;
  final Color backgroundColor;
  final Color lineColor;

  // Move ValueNotifier to a class-level final variable
  final ValueNotifier<List<int>> valueNotifier;

  CustomLineChart({
    super.key,
    this.backgroundColor = Colors.white,
    required this.dataValue,
    required this.height,
    required this.width,
    this.lineColor = Colors.pink,
  }) : valueNotifier = ValueNotifier(dataValue[dataValue.keys.first]);
  // print("xxxxxx $value");;

  @override
  Widget build(BuildContext context) {
    final bootomTileValue = dataValue.keys
        .map((key) =>
            key.substring(0, key.length > 3 ? 3 : 1)) // Convert to uppercase
        .toList();
    final ValueNotifier<String> keyValue = ValueNotifier(bootomTileValue.first);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width / height * 10),
        color: lineColor.withOpacity(0.1),
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
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: height / 10),
                child: AspectRatio(
                  aspectRatio: height / width,
                  child: ValueListenableBuilder(
                      valueListenable: valueNotifier,
                      builder: (context, value, child) {
                        return LineChart(
                          LineFunction().sampleData1(value),
                          duration: const Duration(milliseconds: 250),
                        );
                      }),
                ),
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
                        // print(dataValue.keys.toList()[index]);
                        valueNotifier.value =
                            dataValue[dataValue.keys.toList()[index]];
                      },
                      child: ValueListenableBuilder(
                          valueListenable: keyValue,
                          builder: (context, value, child) {
                            return Text(bootomTileValue[index],
                                style: bootomTileValue[index] == value
                                    ? TextStyle(
                                        color: lineColor,
                                        fontWeight: FontWeight.bold)
                                    : null);
                          }),
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
