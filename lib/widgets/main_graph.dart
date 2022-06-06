import 'package:flutter/material.dart';
import 'package:seismic_visualization/widgets/helicorder.dart';
import 'package:seismic_visualization/widgets/jsonParser.dart';
import 'dart:html' as html;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:async';

class RealTimeData extends StatefulWidget {
  final networkHolder;
  final stationHolder;
  final locationHolder;

  RealTimeData(
      {Key? key,
      @required this.networkHolder,
      this.stationHolder,
      this.locationHolder})
      : super(key: key);
  // final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<RealTimeData> {
  late TooltipBehavior _tooltipBehavior;
  late ZoomPanBehavior _zoomPanBehavior;
  late Future<List<DataList>> chartData;
  late List<DataList> chartData2 = [];
  late List<DataList> lowerSplitList = [];
  late List<DataList> upperSplitList = [];

  late ChartSeriesController _chartSeriesController;
  late var time = 0;
  late var lowerSize = 0;

  Future<void> getChartData() async {
    chartData = liveDataParsing('' + widget.networkHolder,
        '' + widget.stationHolder, '' + widget.locationHolder);
    chartData2 = await chartData;
    var size = chartData2.length;
    var range = (size / 3).truncate();
    lowerSplitList = chartData2.getRange(0, range).toList();
    lowerSize = lowerSplitList.length;
    upperSplitList = chartData2.getRange(range, size).toList();
    time = size;
  }

  void refreshData() async {
    setState(() {
      getChartData();
    });
  }

  Future<void> _updateDataSource(Timer timer) async {
    lowerSplitList.add(DataList(time: lowerSize++, y: upperSplitList[0].y));
    lowerSplitList.removeAt(0);
    upperSplitList.removeAt(0);
    if (upperSplitList.length < 5) {
      refreshData();
    }
    _chartSeriesController.updateDataSource(
      addedDataIndex: lowerSplitList.length - 1,
      removedDataIndex: 0,
    );
  }

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true, format: 'point.y');
    _zoomPanBehavior = ZoomPanBehavior(
        enableDoubleTapZooming: true,
        zoomMode: ZoomMode.xy,
        enablePanning: true);
    getChartData();
    Timer.periodic(const Duration(milliseconds: 1000), _updateDataSource);

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
              'Realtime',
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Helicorder(
                              networkHolder: widget.networkHolder,
                              stationHolder: widget.stationHolder,
                              locationHolder: widget.locationHolder)));
                },
                child: const Text('Helicorder'),
              ),
            ],
            leading: IconButton(
              color: Colors.black,
              icon: const Icon(Icons.add_chart),
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
            )),
        body: Center(
          child: FutureBuilder(
              future: chartData,
              builder: (context, AsyncSnapshot<List<DataList>> snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const CircularProgressIndicator();
                } else {
                  if (snapshot.hasError) {
                    return Column(
                      children: [
                        const Icon(Icons.error),
                        const Text(
                            'Incorrect query parameters or the station is not responding'),
                        ElevatedButton(
                          child: const Text('Reload'),
                          onPressed: () {
                            html.window.location.reload();
                          },
                        ),
                      ],
                    );
                  } else {
                    print(snapshot.connectionState);
                    return SfCartesianChart(
                        title: ChartTitle(
                            text: '' +
                                widget.networkHolder +
                                '.' +
                                widget.stationHolder +
                                '.' +
                                widget.locationHolder +
                                '.LH?'),
                        legend: Legend(isVisible: true),
                        tooltipBehavior: _tooltipBehavior,
                        zoomPanBehavior: _zoomPanBehavior,
                        series: <ChartSeries>[
                          LineSeries<DataList, int>(
                              name: 'Amplitude',
                              onRendererCreated:
                                  (ChartSeriesController controller) {
                                _chartSeriesController = controller;
                              },
                              dataSource: lowerSplitList,
                              xValueMapper: (DataList sales, _) => sales.time,
                              yValueMapper: (DataList sales, _) => sales.y,
                              enableTooltip: true)
                        ],
                        primaryXAxis: NumericAxis(
                          edgeLabelPlacement: EdgeLabelPlacement.shift,
                          isVisible: false,
                          title: AxisTitle(text: 'Time (seconds)'),
                        ),
                        primaryYAxis: NumericAxis(
                          title: AxisTitle(text: 'Amplitude (centered)'),
                        ));
                  }
                }
              }),
        ));
  }
}
