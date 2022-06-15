import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pantra_project/pages/home.dart';
import 'package:pantra_project/pages/login.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyApp(),
      theme: ThemeData(fontFamily: 'Recoleta'),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late AnimationController _contrtoller;
  startTimer() async {
    Timer(const Duration(seconds: 4), nextScreen);
  }

  void nextScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Login()));
  }

  @override
  void initState() {
    _contrtoller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _contrtoller.forward();
    startTimer();
    super.initState();
  }

  Animation<Offset> generateAnimation(double startOffset, double endInterval) {
    return Tween<Offset>(
      begin: Offset(startOffset, 0.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _contrtoller,
        curve: Interval(0.0, endInterval, curve: Curves.elasticOut),
      ),
    );
  }

  SlideTransition generateSlideTransition(
      double startOffset, double endInterval, String thetext) {
    return SlideTransition(
      position: generateAnimation(startOffset, endInterval),
      child: Text(thetext,
          style: const TextStyle(
              fontSize: 50,
              color: Color.fromRGBO(60, 108, 180, 1),
              fontFamily: 'Recoleta')),
    );
  }

  @override
  void dispose() {
    _contrtoller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(249, 234, 213, 1),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            generateSlideTransition(-5, 0.5, "P"),
            generateSlideTransition(-6, 0.6, "A"),
            generateSlideTransition(-7, 0.7, "N"),
            generateSlideTransition(-8, 0.8, "T"),
            generateSlideTransition(-9, 0.9, "R"),
            generateSlideTransition(-10, 1.0, "A"),
          ],
        ),
      ),
    );
  }
}
