@JS()
library stringify;

import 'package:flutter/material.dart';
import 'dart:html';
import 'dart:ui' as ui;
import 'package:js/js.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    //context.callMethod('alert', ['Hello from Dart!']);
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    DivElement div = DivElement();
    div.text = 'New Div Element';
    document.body?.children.add(div);

//    ui.platformViewRegistry.registerViewFactory(
//         'test-view-type',
//         (int viewId) => IFrameElement()
//           ..width = '640'
//           ..height = '360'
//           ..src = 'graphTutorial.html'
//           // ..src = "https://www.youtube.com/embed/5VbAwhBBHsg"
//           ..style.border = 'none');

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Text('Testing Iframe with Flutter'),
          HtmlElementView(viewType: 'test-view-type'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
