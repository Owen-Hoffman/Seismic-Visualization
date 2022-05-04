import 'package:flutter/material.dart';
import 'dart:js_util';
import 'package:js/js.dart';
import 'dart:convert';

@JS()
external getSeismicData(String stationCode);

class TestList {
  final int time;
  final int y;

  @override
  TestList({
    required this.time,
    required this.y,
  });
  String toString() {
    return '{ ${this.time}, ${this.y} }';
  }
}

Future dataParsing() async {
  var promise = promiseToFuture<String>(getSeismicData('HODGE'));
  var queryData = await promise;
  Map<String, dynamic> decodeData =
      jsonDecode(queryData) as Map<String, dynamic>;
  var tagObjsJson = decodeData['_seismogram']['_segmentArray'][0]['_y'];
  int i = 0;
  List<TestList> parsedList = [];
  while (i < tagObjsJson.length) {
    parsedList.add(TestList(time: i, y: tagObjsJson['$i']));
    i++;
  }
  // print(parsedList);
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
                    List<TestList> data = await dataParsing();
                    print(data);
                    print(data.runtimeType);
                  }),
            ),
          )),
    );
  }
}
