import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:async';
import 'dart:math' as math;

class RealTimeData extends StatefulWidget {
  RealTimeData({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<RealTimeData> {
  late List<LiveData> chartData;
  late List<LiveData> chartData2;
  late List<LiveData> chartData3;

  late ChartSeriesController _chartSeriesController;
  late ZoomPanBehavior _zoomPanBehavior;

  @override
  void initState() {
    chartData = getChartData();

    _zoomPanBehavior = ZoomPanBehavior(
        enableDoubleTapZooming: true,
        zoomMode: ZoomMode.xy,
        enablePanning: true);

    Timer.periodic(const Duration(seconds: 2), updateDataSource);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Realtime Data'), actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              primary: Colors.white,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/Helicorder');
            },
            child: const Text('Helicorder'),
          ),
        ]),
        body: Center(
            child: Container(
                child: Scaffold(
                    body: SfCartesianChart(
                        zoomPanBehavior: _zoomPanBehavior,
                        series: <ChartSeries<LiveData, int>>[
                          LineSeries<LiveData, int>(
                            onRendererCreated:
                                (ChartSeriesController controller) {
                              _chartSeriesController = controller;
                            },
                            dataSource: chartData,
                            color: const Color.fromRGBO(192, 108, 132, 1),
                            xValueMapper: (LiveData sales, _) => sales.time,
                            yValueMapper: (LiveData sales, _) => sales.speed,
                          ),
                        ],
                        primaryXAxis: CategoryAxis(
                            majorGridLines: const MajorGridLines(width: 0),
                            edgeLabelPlacement: EdgeLabelPlacement.shift,
                            interval: 3,
                            title: AxisTitle(text: 'Time (seconds)')),
                        primaryYAxis: NumericAxis(
                            axisLine: const AxisLine(width: 0),
                            majorTickLines: const MajorTickLines(size: 0),
                            title: AxisTitle(text: 'Magnitude')))))));
  }

  int time = 19;
  void updateDataSource(Timer timer) {
    chartData.add(LiveData(time++, (math.Random().nextInt(60) + 30)));
    chartData.removeAt(0);
    _chartSeriesController.updateDataSource(
        addedDataIndex: chartData.length - 1, removedDataIndex: 0);
  }

  List<LiveData> getChartData() {
    return <LiveData>[
      LiveData(0, 42),
      LiveData(1, 47),
      LiveData(2, 43),
      LiveData(3, 49),
      LiveData(4, 54),
      LiveData(5, 41),
      LiveData(6, 58),
      LiveData(7, 51),
      LiveData(8, 98),
      LiveData(9, 41),
      LiveData(10, 53),
      LiveData(11, 72),
      LiveData(12, 86),
      LiveData(13, 52),
      LiveData(14, 94),
      LiveData(15, 92),
      LiveData(16, 86),
      LiveData(17, 72),
      LiveData(18, 94)
    ];
  }
}

class LiveData {
  LiveData(this.time, this.speed);
  final int time;
  final num speed;
}
