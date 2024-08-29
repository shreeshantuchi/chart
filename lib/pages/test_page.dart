import 'dart:math';

import 'package:custom_chart/services/line_function.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  List<int> linedata = [];
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder<int>(
            stream: getStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  linedata.add(snapshot.data!);
                  double chartWidth = linedata.length * 50.0;

                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (_scrollController.hasClients) {
                      _scrollController.animateTo(
                          _scrollController.position.maxScrollExtent,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.fastOutSlowIn);
                    }
                  });

                  return Center(
                    child: Container(
                      width: 300,
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          height: 400,
                          width: chartWidth,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 200, 50, 0),
                            child: LineChart(
                              curve: Curves.fastOutSlowIn,
                              LineFunction().sampleData1(linedata),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }
}

Stream<int> getStream() {
  final random = Random();
  final stream = Stream<int>.periodic(
    Duration(seconds: 1),
    (count) => (random.nextInt(80) +
        30), // Generates a random integer between 0 and 90
  );
  return stream;
}
