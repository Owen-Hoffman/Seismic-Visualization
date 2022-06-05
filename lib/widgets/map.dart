import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color hexToColor(String code) {
      return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
    }

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Welcome to Flutter",
        home: Material(
            child: Container(
                padding: const EdgeInsets.all(30.0),
                color: Colors.white,
                child: Center(
                    child: Column(children: [
                  const Padding(padding: EdgeInsets.only(top: 140.0)),
                  Text(
                    'Station Query',
                    style:
                        TextStyle(color: hexToColor("#7393B3"), fontSize: 25.0),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 50.0)),
                  Column(children: [
                    SizedBox(
                      width: 500,
                      child: TextFormField(
                        initialValue: 'IU',
                        decoration: InputDecoration(
                          labelText: "Network Code",
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: const BorderSide(),
                          ),
                        ),
                        validator: (val) {
                          if (val?.length == 0) {
                            return "Field cannot be empty";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 30.0)),
                    SizedBox(
                      width: 500,
                      child: TextFormField(
                        initialValue: 'ANMO',
                        decoration: InputDecoration(
                          labelText: "Station Code",
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: const BorderSide(),
                          ),
                        ),
                        validator: (val) {
                          if (val?.length == 0) {
                            return "Field cannot be empty";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 30.0)),
                    SizedBox(
                      width: 500,
                      child: TextFormField(
                        initialValue: '00',
                        decoration: InputDecoration(
                          labelText: "Location Code",
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: const BorderSide(),
                          ),
                        ),
                        validator: (val) {
                          if (val?.length == 0) {
                            return "Field cannot be empty";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 20.0)),
                    ElevatedButton(
                        child: Text("Submit"),
                        onPressed: () async {
                          print("data passed");
                        }),
                  ])
                ])))));
  }
}
