import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Helicorder extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  Helicorder({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Helicorder> {
  late ZoomPanBehavior _zoomPanBehavior;

  @override
  void initState() {
    _zoomPanBehavior = ZoomPanBehavior(
      enableDoubleTapZooming: true,
      zoomMode: ZoomMode.xy,
      enablePanning: true,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Helicorder'), actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              primary: Colors.white,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
            child: const Text('Realtime Graph'),
          ),
        ]),
        body: Center(
          //Initialize the chart widget
          child: Container(
              height: 1920,
              width: 1080,
              child: SfCartesianChart(
                  zoomPanBehavior: _zoomPanBehavior,
                  backgroundColor: Colors.white,
                  primaryXAxis: DateTimeAxis(
                      majorGridLines: MajorGridLines(width: 0),
                      edgeLabelPlacement: EdgeLabelPlacement.shift,
                      intervalType: DateTimeIntervalType.minutes),
                  series: <ChartSeries<ChartSampleData, DateTime>>[
                    StackedLineSeries<ChartSampleData, DateTime>(
                      dataSource: chartData,
                      xValueMapper: (ChartSampleData sales, _) => sales.x,
                      yValueMapper: (ChartSampleData sales, _) => sales.yValue,
                      name: '0-2',
                    ),
                    StackedLineSeries<ChartSampleData, DateTime>(
                      dataSource: chartData,
                      xValueMapper: (ChartSampleData sales, _) => sales.x,
                      yValueMapper: (ChartSampleData sales, _) => sales.yValue,
                      name: '2-4',
                    ),
                    StackedLineSeries<ChartSampleData, DateTime>(
                      dataSource: chartData,
                      xValueMapper: (ChartSampleData sales, _) => sales.x,
                      yValueMapper: (ChartSampleData sales, _) => sales.yValue,
                      name: '4-6',
                    ),
                    StackedLineSeries<ChartSampleData, DateTime>(
                      dataSource: chartData,
                      xValueMapper: (ChartSampleData sales, _) => sales.x,
                      yValueMapper: (ChartSampleData sales, _) => sales.yValue,
                      name: '6-8',
                    ),
                    StackedLineSeries<ChartSampleData, DateTime>(
                      dataSource: chartData,
                      xValueMapper: (ChartSampleData sales, _) => sales.x,
                      yValueMapper: (ChartSampleData sales, _) => sales.yValue,
                      name: '8-10',
                    ),
                    StackedLineSeries<ChartSampleData, DateTime>(
                      dataSource: chartData,
                      xValueMapper: (ChartSampleData sales, _) => sales.x,
                      yValueMapper: (ChartSampleData sales, _) => sales.yValue,
                      name: '10-12',
                    ),
                    StackedLineSeries<ChartSampleData, DateTime>(
                      dataSource: chartData,
                      xValueMapper: (ChartSampleData sales, _) => sales.x,
                      yValueMapper: (ChartSampleData sales, _) => sales.yValue,
                      name: '12-14',
                    ),
                    StackedLineSeries<ChartSampleData, DateTime>(
                      dataSource: chartData,
                      xValueMapper: (ChartSampleData sales, _) => sales.x,
                      yValueMapper: (ChartSampleData sales, _) => sales.yValue,
                      name: '14-16',
                    ),
                    StackedLineSeries<ChartSampleData, DateTime>(
                      dataSource: chartData,
                      xValueMapper: (ChartSampleData sales, _) => sales.x,
                      yValueMapper: (ChartSampleData sales, _) => sales.yValue,
                      name: '16-18',
                    ),
                    StackedLineSeries<ChartSampleData, DateTime>(
                      dataSource: chartData,
                      xValueMapper: (ChartSampleData sales, _) => sales.x,
                      yValueMapper: (ChartSampleData sales, _) => sales.yValue,
                      name: '18-20',
                    ),
                    StackedLineSeries<ChartSampleData, DateTime>(
                      dataSource: chartData,
                      xValueMapper: (ChartSampleData sales, _) => sales.x,
                      yValueMapper: (ChartSampleData sales, _) => sales.yValue,
                      name: '20-22',
                    ),
                    StackedLineSeries<ChartSampleData, DateTime>(
                      dataSource: chartData,
                      xValueMapper: (ChartSampleData sales, _) => sales.x,
                      yValueMapper: (ChartSampleData sales, _) => sales.yValue,
                      name: '22-24',
                    )
                  ])),
        ));
  }

  List<ChartSampleData> chartData = <ChartSampleData>[
    ChartSampleData(x: DateTime(2022, 1, 1, 1), yValue: 1.13),
    ChartSampleData(x: DateTime(2022, 1, 2, 2), yValue: 1.12),
    ChartSampleData(x: DateTime(2022, 1, 3, 3), yValue: 1.08),
    ChartSampleData(x: DateTime(2022, 1, 4, 4), yValue: 1.12),
    ChartSampleData(x: DateTime(2022, 1, 5, 5), yValue: 1.1),
    ChartSampleData(x: DateTime(2022, 1, 6, 6), yValue: 1.12),
    ChartSampleData(x: DateTime(2022, 1, 7, 7), yValue: 1.1),
    ChartSampleData(x: DateTime(2022, 1, 8, 8), yValue: 1.12),
    ChartSampleData(x: DateTime(2022, 1, 9, 9), yValue: 1.16),
    ChartSampleData(x: DateTime(2022, 1, 10, 10), yValue: 1.1),
    ChartSampleData(x: DateTime(2022, 1, 11, 11), yValue: 1.1),
    ChartSampleData(x: DateTime(2022, 1, 12, 12), yValue: 1.1),
  ];
}

class ChartSampleData {
  ChartSampleData({this.x, this.yValue});

  final DateTime? x;
  final double? yValue;
}
