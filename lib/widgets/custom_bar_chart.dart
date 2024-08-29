import 'package:custom_chart/services/bar_function.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class CustomBarChart extends StatelessWidget {
  final double height;
  final double width;
  final Map<String, dynamic> dataValue;
  final Color barColor;

  // Move ValueNotifier to a class-level final variable

  CustomBarChart({
    super.key,
    required this.dataValue,
    required this.height,
    required this.width,
    this.barColor = Colors.indigo,
  });
  final stream = BehaviorSubject<String>();

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
                child: StreamBuilder(
                    stream: stream,
                    initialData: dataValue.keys.toList()[0],
                    builder: (context, snapshot) {
                      return BarChart(
                        BarFunction()
                            .mainBarData(dataValue[snapshot.data], barColor),
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
                        stream.add(dataValue.keys.toList()[index]);
                      },
                      child: StreamBuilder(
                        stream: stream,
                        initialData: bootomTileValue.first,
                        builder: (context, snapshot) {
                          return Text(bootomTileValue[index],
                              style: bootomTileValue[index] ==
                                      snapshot.data!.substring(0, 3)
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
