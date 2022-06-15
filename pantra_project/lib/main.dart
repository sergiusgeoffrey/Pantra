import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Pantra",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Pantra"),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Container(),
        ),
      )
    );
  }
}