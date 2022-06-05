import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:seismic_visualization/widgets/jsonParser.dart';

class Helicorder extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  Helicorder({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Helicorder> {
  late ZoomPanBehavior _zoomPanBehavior;
  late TooltipBehavior _tooltipBehavior;

  late Future<List<DataList>> futureChartData;
  late int size;

  Future<void> getChartData() async {
    futureChartData = dataParsing();
  }

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true, format: 'point.y');
    _zoomPanBehavior = ZoomPanBehavior(
      enableDoubleTapZooming: true,
      zoomMode: ZoomMode.xy,
      enablePanning: true,
    );
    getChartData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              'Helicorder',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.black,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                },
                child: const Text('Realtime'),
              ),
            ]),
        body: Center(
          child: FutureBuilder(
              future: futureChartData,
              builder: (context, AsyncSnapshot<List<DataList>> snapshot) {
                if (!snapshot.hasData) {
                  return const Text("loading data");
                } else {
                  if (snapshot.hasError) {
                    return const Text("unknown error");
                  } else {
                    return SfCartesianChart(
                        title: ChartTitle(
                            text: 'CO.HODGE.OO.LHZ: 2022-05-06T03:19:53Z'),
                        legend: Legend(isVisible: true),
                        // tooltipBehavior: _tooltipBehavior,
                        // zoomPanBehavior: _zoomPanBehavior,
                        backgroundColor: Colors.transparent,
                        primaryXAxis: CategoryAxis(
                            title: AxisTitle(text: 'Time (seconds)'),
                            isVisible: false),
                        primaryYAxis: NumericAxis(
                          isVisible: false,
                        ),
                        axes: <ChartAxis>[
                          NumericAxis(
                            name: 'xAxis2',
                            isVisible: false,
                          ),
                          NumericAxis(
                            name: 'xAxis3',
                            isVisible: false,
                          ),
                          NumericAxis(
                            name: 'xAxis4',
                            isVisible: false,
                          ),
                          NumericAxis(
                            name: 'xAxis5',
                            isVisible: false,
                          ),
                          NumericAxis(
                            name: 'xAxis6',
                            isVisible: false,
                          ),
                          NumericAxis(
                            name: 'xAxis7',
                            isVisible: false,
                          ),
                          NumericAxis(
                            name: 'xAxis8',
                            isVisible: false,
                          ),
                          NumericAxis(
                            name: 'xAxis9',
                            isVisible: false,
                          ),
                          NumericAxis(
                            name: 'xAxis10',
                            isVisible: false,
                          ),
                          NumericAxis(
                            name: 'xAxis11',
                            isVisible: false,
                          ),
                          NumericAxis(
                            name: 'xAxis12',
                            isVisible: false,
                          ),
                        ],
                        series: <ChartSeries>[
                          LineSeries<DataList, int>(
                              dataSource:
                                  snapshot.data!.getRange(0, 240).toList(),
                              xValueMapper: (DataList sales, _) => sales.time,
                              yValueMapper: (DataList sales, _) =>
                                  sales.y + 200,
                              name: '00:00',
                              width: 2),
                          LineSeries<DataList, int>(
                            dataSource:
                                snapshot.data!.getRange(240, 480).toList(),
                            xValueMapper: (DataList sales, _) => sales.time,
                            yValueMapper: (DataList sales, _) => sales.y,
                            name: '02:00',
                            width: 2,
                            xAxisName: 'xAxis2',
                          ),
                          LineSeries<DataList, int>(
                              dataSource:
                                  snapshot.data!.getRange(480, 720).toList(),
                              xValueMapper: (DataList sales, _) => sales.time,
                              yValueMapper: (DataList sales, _) =>
                                  sales.y - 200,
                              name: '04:00',
                              width: 2,
                              xAxisName: 'xAxis3'),
                          LineSeries<DataList, int>(
                              dataSource:
                                  snapshot.data!.getRange(720, 960).toList(),
                              xValueMapper: (DataList sales, _) => sales.time,
                              yValueMapper: (DataList sales, _) =>
                                  sales.y - 400,
                              name: '06:00',
                              width: 2,
                              xAxisName: 'xAxis4'),
                          LineSeries<DataList, int>(
                              dataSource:
                                  snapshot.data!.getRange(960, 1200).toList(),
                              xValueMapper: (DataList sales, _) => sales.time,
                              yValueMapper: (DataList sales, _) =>
                                  sales.y - 600,
                              name: '08:00',
                              width: 2,
                              xAxisName: 'xAxis5'),
                          LineSeries<DataList, int>(
                              dataSource:
                                  snapshot.data!.getRange(1200, 1440).toList(),
                              xValueMapper: (DataList sales, _) => sales.time,
                              yValueMapper: (DataList sales, _) =>
                                  sales.y - 800,
                              name: '10:00',
                              width: 2,
                              xAxisName: 'xAxis6'),
                          LineSeries<DataList, int>(
                              dataSource:
                                  snapshot.data!.getRange(1440, 1680).toList(),
                              xValueMapper: (DataList sales, _) => sales.time,
                              yValueMapper: (DataList sales, _) =>
                                  sales.y - 1000,
                              name: '12:00',
                              width: 2,
                              xAxisName: 'xAxis7'),
                          LineSeries<DataList, int>(
                              dataSource:
                                  snapshot.data!.getRange(1680, 1920).toList(),
                              xValueMapper: (DataList sales, _) => sales.time,
                              yValueMapper: (DataList sales, _) =>
                                  sales.y - 1200,
                              name: '14:00',
                              width: 2,
                              xAxisName: 'xAxis8'),
                          LineSeries<DataList, int>(
                              dataSource:
                                  snapshot.data!.getRange(1920, 2160).toList(),
                              xValueMapper: (DataList sales, _) => sales.time,
                              yValueMapper: (DataList sales, _) =>
                                  sales.y - 1400,
                              name: '16:00',
                              width: 2,
                              xAxisName: 'xAxis9'),
                          LineSeries<DataList, int>(
                              dataSource:
                                  snapshot.data!.getRange(2160, 2400).toList(),
                              xValueMapper: (DataList sales, _) => sales.time,
                              yValueMapper: (DataList sales, _) =>
                                  sales.y - 1600,
                              name: '18:00',
                              width: 2,
                              xAxisName: 'xAxis10'),
                          LineSeries<DataList, int>(
                              dataSource:
                                  snapshot.data!.getRange(2400, 2640).toList(),
                              xValueMapper: (DataList sales, _) => sales.time,
                              yValueMapper: (DataList sales, _) =>
                                  sales.y - 1800,
                              name: '20:00',
                              width: 2,
                              xAxisName: 'xAxis11'),
                          LineSeries<DataList, int>(
                              dataSource: snapshot.data!
                                  .getRange(2640, snapshot.data!.length)
                                  .toList(),
                              xValueMapper: (DataList sales, _) => sales.time,
                              yValueMapper: (DataList sales, _) =>
                                  sales.y - 2000,
                              name: '22:00',
                              width: 2,
                              xAxisName: 'xAxis12'),
                        ]);
                  }
                }
              }),
        ));
  }
}
