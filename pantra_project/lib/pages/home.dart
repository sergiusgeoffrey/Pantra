import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:pantra_project/pages/subpages/event.dart';
import 'package:pantra_project/pages/subpages/student.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> pageList = <Widget>[const EventPage(), const StudentPage()];
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
          color: const Color.fromRGBO(251, 203, 92, 1),
          onTap: (value) {
            setState(() {
              pageIndex = value;
            });
          },
          items: const [
            Icon(
              Icons.home,
              color: Color.fromRGBO(60, 108, 180, 1),
            ),
            Icon(
              Icons.search,
              color: Color.fromRGBO(60, 108, 180, 1),
            ),
            Icon(
              Icons.person,
              color: Color.fromRGBO(60, 108, 180, 1),
            ),
            Icon(
              Icons.delete,
              color: Color.fromRGBO(60, 108, 180, 1),
            ),
          ]),
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: pageList[pageIndex],
    );
  }
}
