import 'package:flutter/material.dart';
import 'widgets/map.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => StationQuery(),
    },
  ));
}
