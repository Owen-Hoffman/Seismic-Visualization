import 'package:flutter/material.dart';
import 'dart:js_util';
import 'package:js/js.dart';

@JS()
external getSeismicData(String stationCode);

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
                    var promise =
                        promiseToFuture<String>(getSeismicData('HODGE'));
                    var queryData = await promise;
                    debugPrint(queryData);
                  }),
            ),
          )),
    );
  }
}
