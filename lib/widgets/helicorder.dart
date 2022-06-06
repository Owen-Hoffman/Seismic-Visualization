import 'package:flutter/material.dart';
import 'package:seismic_visualization/widgets/main_graph.dart';
import 'dart:async';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:seismic_visualization/widgets/jsonParser.dart';
import 'package:intl/intl.dart';
import 'dart:html' as html;

class Helicorder extends StatefulWidget {
  final networkHolder;
  final stationHolder;
  final locationHolder;
  Helicorder(
      {Key? key,
      @required this.networkHolder,
      this.stationHolder,
      this.locationHolder})
      : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Helicorder> {
  late DateTime _dateTime;

  late ZoomPanBehavior _zoomPanBehavior;
  late TooltipBehavior _tooltipBehavior;

  late Future<List<DataList>> futureChartData;
  late int size;
  late String dateTime = '';
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  Future<void> getChartData() async {
    String currentTime = dateFormat.format(DateTime.now()) + 'T00:00:53Z';

    futureChartData = dataParsing('' + widget.networkHolder,
        '' + widget.stationHolder, '' + widget.locationHolder, currentTime);
  }

  void refreshData() {
    dateTime = dateFormat.format(_dateTime) + 'T00:00:53Z';
    print(dateTime);
    setState(() {
      futureChartData = dataParsing('' + widget.networkHolder,
          '' + widget.stationHolder, '' + widget.locationHolder, dateTime);
    });
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
          leading: TextButton(
            style: TextButton.styleFrom(
              primary: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RealTimeData(
                          networkHolder: widget.networkHolder,
                          stationHolder: widget.stationHolder,
                          locationHolder: widget.locationHolder)));
            },
            child: const Text('LIVE'),
          ),
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
            IconButton(
                color: Colors.black,
                icon: const Icon(Icons.calendar_month),
                onPressed: () {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now())
                      .then((date) {
                    _dateTime = date!;
                    print(_dateTime);
                    refreshData();
                  });
                }),
          ],
        ),
        body: Center(
          child: FutureBuilder(
              future: futureChartData,
              builder: (context, AsyncSnapshot<List<DataList>> snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const CircularProgressIndicator();
                } else {
                  if (snapshot.hasError) {
                    return Column(
                      children: [
                        const Icon(Icons.error),
                        const Text(
                            'There was a problem connecting to the station'),
                        ElevatedButton(
                          child: const Text('Reload'),
                          onPressed: () {
                            html.window.location.reload();
                          },
                        ),
                      ],
                    );
                  } else {
                    if (snapshot.data!.length < 1320) {
                      return Column(
                        children: [
                          const Icon(Icons.error),
                          const Text(
                              'The station does not have a complete record of this date'),
                          ElevatedButton(
                            child: const Text('Reload'),
                            onPressed: () {
                              setState(() {
                                getChartData();
                              });
                            },
                          ),
                        ],
                      );
                    } else {
                      return SfCartesianChart(
                          title: ChartTitle(
                              text: '' +
                                  widget.networkHolder +
                                  '.' +
                                  widget.stationHolder +
                                  '.' +
                                  widget.locationHolder +
                                  '.LH? ' +
                                  dateTime),
                          legend: Legend(isVisible: true),
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
                                    snapshot.data!.getRange(0, 120).toList(),
                                xValueMapper: (DataList sales, _) => sales.time,
                                yValueMapper: (DataList sales, _) =>
                                    sales.y + 200,
                                name: '00:00',
                                color: Colors.blue,
                                width: 2),
                            LineSeries<DataList, int>(
                              dataSource:
                                  snapshot.data!.getRange(120, 240).toList(),
                              xValueMapper: (DataList sales, _) => sales.time,
                              yValueMapper: (DataList sales, _) => sales.y,
                              name: '02:00',
                              width: 2,
                              color: Colors.red,
                              xAxisName: 'xAxis2',
                            ),
                            LineSeries<DataList, int>(
                                dataSource:
                                    snapshot.data!.getRange(240, 360).toList(),
                                xValueMapper: (DataList sales, _) => sales.time,
                                yValueMapper: (DataList sales, _) =>
                                    sales.y - 200,
                                color: Colors.green,
                                name: '04:00',
                                width: 2,
                                xAxisName: 'xAxis3'),
                            LineSeries<DataList, int>(
                                dataSource:
                                    snapshot.data!.getRange(360, 480).toList(),
                                xValueMapper: (DataList sales, _) => sales.time,
                                yValueMapper: (DataList sales, _) =>
                                    sales.y - 400,
                                name: '06:00',
                                width: 2,
                                color: Colors.blue,
                                xAxisName: 'xAxis4'),
                            LineSeries<DataList, int>(
                                dataSource:
                                    snapshot.data!.getRange(480, 600).toList(),
                                xValueMapper: (DataList sales, _) => sales.time,
                                yValueMapper: (DataList sales, _) =>
                                    sales.y - 600,
                                name: '08:00',
                                width: 2,
                                color: Colors.red,
                                xAxisName: 'xAxis5'),
                            LineSeries<DataList, int>(
                                dataSource:
                                    snapshot.data!.getRange(600, 720).toList(),
                                xValueMapper: (DataList sales, _) => sales.time,
                                yValueMapper: (DataList sales, _) =>
                                    sales.y - 800,
                                color: Colors.green,
                                name: '10:00',
                                width: 2,
                                xAxisName: 'xAxis6'),
                            LineSeries<DataList, int>(
                                dataSource:
                                    snapshot.data!.getRange(720, 840).toList(),
                                xValueMapper: (DataList sales, _) => sales.time,
                                yValueMapper: (DataList sales, _) =>
                                    sales.y - 1000,
                                color: Colors.blue,
                                name: '12:00',
                                width: 2,
                                xAxisName: 'xAxis7'),
                            LineSeries<DataList, int>(
                                dataSource:
                                    snapshot.data!.getRange(840, 960).toList(),
                                xValueMapper: (DataList sales, _) => sales.time,
                                yValueMapper: (DataList sales, _) =>
                                    sales.y - 1200,
                                name: '14:00',
                                width: 2,
                                color: Colors.red,
                                xAxisName: 'xAxis8'),
                            LineSeries<DataList, int>(
                                dataSource:
                                    snapshot.data!.getRange(960, 1080).toList(),
                                xValueMapper: (DataList sales, _) => sales.time,
                                yValueMapper: (DataList sales, _) =>
                                    sales.y - 1400,
                                name: '16:00',
                                color: Colors.green,
                                width: 2,
                                xAxisName: 'xAxis9'),
                            LineSeries<DataList, int>(
                                dataSource: snapshot.data!
                                    .getRange(1080, 1200)
                                    .toList(),
                                xValueMapper: (DataList sales, _) => sales.time,
                                yValueMapper: (DataList sales, _) =>
                                    sales.y - 1600,
                                color: Colors.blue,
                                name: '18:00',
                                width: 2,
                                xAxisName: 'xAxis10'),
                            LineSeries<DataList, int>(
                                dataSource: snapshot.data!
                                    .getRange(1200, 1320)
                                    .toList(),
                                xValueMapper: (DataList sales, _) => sales.time,
                                yValueMapper: (DataList sales, _) =>
                                    sales.y - 1800,
                                name: '20:00',
                                color: Colors.red,
                                width: 2,
                                xAxisName: 'xAxis11'),
                            LineSeries<DataList, int>(
                                dataSource: snapshot.data!
                                    .getRange(1320, snapshot.data!.length)
                                    .toList(),
                                xValueMapper: (DataList sales, _) => sales.time,
                                yValueMapper: (DataList sales, _) =>
                                    sales.y - 2000,
                                name: '22:00',
                                width: 2,
                                color: Colors.green,
                                xAxisName: 'xAxis12'),
                          ]);
                    }
                  }
                }
              }),
        ));
  }
}
