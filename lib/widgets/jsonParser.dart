import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:js_util';
import 'package:js/js.dart';
import 'dart:convert';
import 'dart:math';

@JS()
external getLiveSeismicData(String networkCode, String stationCode,
    String locationCode, String channelCode);

@JS()
external getSeismicData(String networkCode, String stationCode,
    String locationCode, String channelCode);

class DataList {
  final int time;
  final int y;

  @override
  DataList({
    required this.time,
    required this.y,
  });
  @override
  String toString() {
    return '{ ${this.time}, ${this.y} }';
  }
}

Future<List<DataList>> dataParsing() async {
  var promise =
      await promiseToFuture<String>(getSeismicData('IU', 'ANMO', '00', 'LHZ'));
  Map<String, dynamic> decodeData = jsonDecode(promise) as Map<String, dynamic>;
  var tagObjsJson = decodeData['_seismogram']['_segmentArray'][0]['_y'];
  int i = 0;
  List<DataList> parsedList = [];
  var test = [];
  //add to class and average every 30 seconds
  while (i < tagObjsJson.length) {
    var z = 0;
    var x = 0;
    while (z < 30) {
      if (tagObjsJson['$i'] != null) {
        x = tagObjsJson['$i'] + x;
      }
      i++;
      z++;
    }
    x = (x / 30).round();
    parsedList.add(DataList(time: i, y: x));
    test.add(x);
    // i++;
  }
  // detrend the series

  print("test1");
  print(test);
  List<DataList> detrendList = [];
  print("test");
  for (var i = 1; i < parsedList.length; i++) {
    print("test2");
    // print(test.elementAt(i));
    // print(parsedList.elementAt(i - 1));
    var value = test.elementAt(i) - test.elementAt(i - 1);
    // print(value);
    detrendList.add(DataList(time: i, y: value));
  }
  print("test3");
  print(detrendList);
  print(parsedList);
  return detrendList;
}

// return compute(parsePromise, promise);

// List<DataList> parsePromise(var promise) {
//   Map<String, dynamic> decodeData = jsonDecode(promise) as Map<String, dynamic>;
//   var tagObjsJson = decodeData['_seismogram']['_segmentArray'][0]['_y'];
//   int i = 0;
//   List<DataList> parsedList = [];
//   while (i < tagObjsJson.length) {
//     var z = 0;
//     var x = 0;
//     while (z < 60) {
//       x = tagObjsJson['$i'];
//       i++;
//       z++;
//     }
//     x = (x / 60).round();
//     parsedList.add(DataList(time: i, y: tagObjsJson['$x']));
//     // i++;
//   }
//   return parsedList;
// }

Future<List<DataList>> liveDataParsing() async {
  var promise =
      promiseToFuture<String>(getLiveSeismicData('IU', 'ANMO', '00', 'LH?'));
  var queryData = await promise;
  Map<String, dynamic> decodeData =
      jsonDecode(queryData) as Map<String, dynamic>;
  var tagObjsJson = decodeData['_seismogram']['_segmentArray'][0]['_y'];
  int i = 0;
  List<DataList> parsedList = [];
  while (i < tagObjsJson.length) {
    parsedList.add(DataList(time: i, y: tagObjsJson['$i']));
    i++;
  }
  // print(decodeData);
  // print(parsedList.runtimeType);
  return parsedList;
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Test App",
      home: Scaffold(
          appBar: AppBar(
            title: Text("Call JS Function"),
            backgroundColor: Colors.redAccent,
          ),
          body: Container(
            padding: EdgeInsets.all(20),
            child: Center(
              child: ElevatedButton(
                  child: Text("Show Seismic Data"),
                  onPressed: () async {
                    List<DataList> data = await liveDataParsing();
                    print(data);
                    print(data.runtimeType);
                  }),
            ),
          )),
    );
  }
}
