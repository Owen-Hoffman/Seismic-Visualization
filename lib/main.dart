import 'package:flutter/material.dart';
import 'widgets/main_graph.dart';
import 'widgets/helicorder.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => RealTimeData(),
      '/RealTimeRoute': (context) => RealTimeData(),
      '/HelicorderRoute': (context) => Helicorder(),
    },
  ));
}
