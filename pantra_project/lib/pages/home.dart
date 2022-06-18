import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pantra_project/models/string_obj.dart';
import 'package:pantra_project/pages/student_search_result.dart';
import 'package:pantra_project/pages/subpages/account_detail.dart';
import 'package:pantra_project/pages/subpages/event.dart';
import 'package:pantra_project/pages/subpages/student.dart';
import 'package:pantra_project/utils/alignment.dart';
import 'package:pantra_project/utils/color.dart';
import 'package:pantra_project/utils/font_weight.dart';
import 'package:pantra_project/widget/text.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> pageList = <Widget>[
    const EventPage(),
    const StudentPage(),
    const AccountDetail()
  ];
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();

    @override
    void dispose() {
      nameController.dispose();
      super.dispose();
    }

    Future<void> _showDivisionDialog(double heightposter) async {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: secondary,
            title: TextWidget(
                str: 'Search by Name',
                size: MediaQuery.of(context).size.height * 0.03,
                color: primary,
                weight: bold,
                alignment: center),
            content: SizedBox(
              width: heightposter,
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Search by Name',
                ),
                controller: nameController,
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: TextWidget(
                    str: 'Search',
                    size: 14,
                    color: primary,
                    weight: bold,
                    alignment: center),
                onPressed: () {
                  var name = nameController.text;
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StudentSearchResult(
                        name: name,
                      ),
                    ),
                  );
                  setState(() {
                    nameController.clear();
                  });
                },
              ),
            ],
          );
        },
      );
    }

    final user = FirebaseAuth.instance;
    double heightposter = 0;
    if (MediaQuery.of(context).size.height >
        MediaQuery.of(context).size.width) {
      heightposter = (MediaQuery.of(context).size.width * 0.75);
    } else {
      heightposter = (MediaQuery.of(context).size.height * 0.75);
    }
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: white,
        color: secondary,
        onTap: (value) {
          setState(() {
            pageIndex = value;
          });
        },
        items: const [
          Icon(
            Icons.celebration_rounded,
            color: primary,
          ),
          Icon(
            Icons.people_alt,
            color: primary,
          ),
          Icon(
            Icons.person,
            color: primary,
          ),
        ],
      ),
      backgroundColor: white,
      body: pageList[pageIndex],
      floatingActionButton: new FloatingActionButton(
        backgroundColor: primary,
        onPressed: () {
          _showDivisionDialog(heightposter);
        },
        child: Icon(Icons.search),
      ),
    );
  }
}
