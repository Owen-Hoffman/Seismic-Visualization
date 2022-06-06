import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:js_util';
import 'package:js/js.dart';
import 'dart:convert';

@JS()
external getLiveSeismicData(String networkCode, String stationCode,
    String locationCode, String channelCode);

@JS()
external getSeismicData(String networkCode, String stationCode,
    String locationCode, String startTime);

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

Future<List<DataList>> dataParsing(String networkCode, String stationCode,
    String locationCode, String startTime) async {
  var promise = await promiseToFuture<String>(
      getSeismicData(networkCode, stationCode, locationCode, startTime));
  //isolate heavy parsing task
  return compute(parsePromise, promise);
}

List<DataList> parsePromise(var promise) {
  Map<String, dynamic> decodeData = jsonDecode(promise) as Map<String, dynamic>;
  var tagObjsJson = decodeData['_seismogram']['_segmentArray'][0]['_y'];
  int i = 0;
  List<DataList> parsedList = [];
  var test = [];
  //add to class and average every minute
  while (i < tagObjsJson.length) {
    var z = 0;
    var x = 0;
    while (z < 60) {
      if (tagObjsJson['$i'] != null) {
        x = tagObjsJson['$i'] + x;
      }
      i++;
      z++;
    }
    x = (x / 60).round();
    parsedList.add(DataList(time: i, y: x));
    test.add(x);
    // i++;
  }
  // detrend the series
  List<DataList> detrendList = [];
  for (var i = 1; i < parsedList.length; i++) {
    var value = test.elementAt(i) - test.elementAt(i - 1);
    detrendList.add(DataList(time: i, y: value));
  }
  return detrendList;
}

Future<List<DataList>> liveDataParsing(
    String networkCode, String stationCode, String locationCode) async {
  var promise = await promiseToFuture<String>(
      getLiveSeismicData(networkCode, stationCode, locationCode, 'LH?'));
  Map<String, dynamic> decodeData = jsonDecode(promise) as Map<String, dynamic>;
  var tagObjsJson = decodeData['_seismogram']['_segmentArray'][0]['_y'];
  int i = 0;
  List<DataList> parsedList = [];
  while (i < tagObjsJson.length) {
    parsedList.add(DataList(time: i, y: tagObjsJson['$i']));
    i++;
  }
  return parsedList;
}
