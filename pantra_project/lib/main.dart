// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pantra_project/page/home.dart';
import 'package:pantra_project/page/login.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
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
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
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
          style: TextStyle(
              fontSize: 50,
              color: Color.fromRGBO(60, 108, 180, 1),
              fontFamily: 'Recoleta')),
    );
  }

  // late final Animation<Offset> _offsetAnimation = Tween<Offset>(
  //   begin: const Offset(-5, 0.0),
  //   end: Offset.zero,
  // ).animate(CurvedAnimation(
  //   parent: _contrtoller,
  //   curve: Interval(0.0, 0.5, curve: Curves.elasticOut),
  // ));
  // late final Animation<Offset> _offsetAnimation2 = Tween<Offset>(
  //   begin: const Offset(-6, 0.0),
  //   end: Offset.zero,
  // ).animate(CurvedAnimation(
  //   parent: _contrtoller,
  //   curve: Interval(0.0, 0.6, curve: Curves.elasticOut),
  // ));
  // late final Animation<Offset> _offsetAnimation3 = Tween<Offset>(
  //   begin: const Offset(-7, 0.0),
  //   end: Offset.zero,
  // ).animate(CurvedAnimation(
  //   parent: _contrtoller,
  //   curve: Interval(0.0, 0.7, curve: Curves.elasticOut),
  // ));
  // late final Animation<Offset> _offsetAnimation4 = Tween<Offset>(
  //   begin: const Offset(-8, 0.0),
  //   end: Offset.zero,
  // ).animate(CurvedAnimation(
  //   parent: _contrtoller,
  //   curve: Interval(0.0, 0.8, curve: Curves.elasticOut),
  // ));
  // late final Animation<Offset> _offsetAnimation5 = Tween<Offset>(
  //   begin: const Offset(-9, 0.0),
  //   end: Offset.zero,
  // ).animate(CurvedAnimation(
  //   parent: _contrtoller,
  //   curve: Interval(0.0, 0.9, curve: Curves.elasticOut),
  // ));
  // late final Animation<Offset> _offsetAnimation6 = Tween<Offset>(
  //   begin: const Offset(-10, 0.0),
  //   end: Offset.zero,
  // ).animate(CurvedAnimation(
  //   parent: _contrtoller,
  //   curve: Interval(0.0, 1.0, curve: Curves.elasticOut),
  // ));

  @override
  void dispose() {
    _contrtoller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(249, 234, 213, 1),
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
            // SlideTransition(
            //   position: _offsetAnimation,
            //   child: SvgPicture.asset("svg/star.svg",
            //       height: 50,
            //       width: 50,
            //       color: Color.fromRGBO(60, 108, 180, 1)),
            // ),
            // SlideTransition(
            //   position: _offsetAnimation,
            //   child: const Text("P",
            //       style: TextStyle(
            //           fontSize: 50,
            //           color: Color.fromRGBO(60, 108, 180, 1),
            //           fontFamily: 'Recoleta')),
            // ),
            // SlideTransition(
            //   position: _offsetAnimation2,
            //   child: const Text("A",
            //       style: TextStyle(
            //           fontSize: 50,
            //           color: Color.fromRGBO(60, 108, 180, 1),
            //           fontFamily: 'Recoleta')),
            // ),
            // SlideTransition(
            //   position: _offsetAnimation3,
            //   child: const Text("N",
            //       style: TextStyle(
            //           fontSize: 50,
            //           color: Color.fromRGBO(60, 108, 180, 1),
            //           fontFamily: 'Recoleta')),
            // ),
            // SlideTransition(
            //   position: _offsetAnimation4,
            //   child: const Text("T",
            //       style: TextStyle(
            //           fontSize: 50,
            //           color: Color.fromRGBO(60, 108, 180, 1),
            //           fontFamily: 'Recoleta')),
            // ),
            // SlideTransition(
            //   position: _offsetAnimation5,
            //   child: const Text("R",
            //       style: TextStyle(
            //           fontSize: 50,
            //           color: Color.fromRGBO(60, 108, 180, 1),
            //           fontFamily: 'Recoleta')),
            // ),
            // SlideTransition(
            //   position: _offsetAnimation6,
            //   child: const Text("A",
            //       style: TextStyle(
            //           fontSize: 50,
            //           color: Color.fromRGBO(60, 108, 180, 1),
            //           fontFamily: 'Recoleta')),
            // ),
            // SlideTransition(
            //   position: _offsetAnimation6,
            //   child: SvgPicture.asset("svg/star.svg",
            //       height: 50,
            //       width: 50,
            //       color: Color.fromRGBO(60, 108, 180, 1)),
            // ),
          ],
        ),
      ),
    );
  }
}
