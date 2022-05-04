import 'package:flutter/material.dart';
import 'package:seismic_visualization/widgets/jsonParser.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'dart:math' as math;

class RealTimeData extends StatefulWidget {
  RealTimeData({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<RealTimeData> {
  late TooltipBehavior _tooltipBehavior;
  late ZoomPanBehavior _zoomPanBehavior;
  late List<TestList> chartData2;

  Future<List<TestList>> getChartData2() async {
    List<TestList> data = await dataParsing();
    print(data);
    return data;
  }

  Future loadchartData() async {
    chartData2 = await getChartData2();
  }

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    _zoomPanBehavior = ZoomPanBehavior(
        enableDoubleTapZooming: true,
        zoomMode: ZoomMode.xy,
        enablePanning: true);
    loadchartData();
    super.initState();
    print("test");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FutureBuilder(
              future: getChartData2(),
              builder: (context, snapshot) {
                return SfCartesianChart(
                    title: ChartTitle(text: 'Live Data'),
                    legend: Legend(isVisible: true),
                    tooltipBehavior: _tooltipBehavior,
                    zoomPanBehavior: _zoomPanBehavior,
                    series: <ChartSeries>[
                      LineSeries<TestList, int>(
                          name: 'Magnitude',
                          dataSource: chartData2,
                          xValueMapper: (TestList sales, _) => sales.time,
                          yValueMapper: (TestList sales, _) => sales.y,
                          // dataLabelSettings: DataLabelSettings(isVisible: true),
                          enableTooltip: true)
                    ],
                    primaryXAxis: NumericAxis(
                      edgeLabelPlacement: EdgeLabelPlacement.shift,
                      title: AxisTitle(text: 'Time (seconds)'),
                    ),
                    primaryYAxis: NumericAxis(
                      // labelFormat: '{value}M',
                      // numberFormat:
                      //     NumberFormat.simpleCurrency(decimalDigits: 0)),
                      title: AxisTitle(text: 'Magnitude'),
                    ));
              })),
    );
  }
}
