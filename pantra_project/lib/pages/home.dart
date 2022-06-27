import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;
import 'package:pantra_project/pages/event.dart';
import 'package:pantra_project/pages/nav_bar.dart';
import 'package:pantra_project/pages/student.dart';
import 'package:pantra_project/services/student/student_name.dart';
import 'package:pantra_project/utils/alignment.dart';
import 'package:pantra_project/utils/color.dart';
import 'package:pantra_project/utils/font_weight.dart';
import 'package:pantra_project/widget/text.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final user = FirebaseAuth.instance;

  final StudentNameService _studentNameService = StudentNameService();

  String getTime() {
    var now = DateTime.now();
    if (now.hour < 12) {
      return 'Morning 🕊️';
    } else if (now.hour < 18) {
      return 'Afternoon 🌞';
    } else {
      return 'Evening 🌜';
    }
  }

  @override
  Widget build(BuildContext context) {
    String titleCase(str) {
      var splitStr = str.toLowerCase().split(' ');
      for (var i = 0; i < splitStr.length; i++) {
        splitStr[i] = splitStr[i][0].toUpperCase() + splitStr[i].substring(1);
      }
      return splitStr.join(' ');
    }

    return Scaffold(
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            color: background,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            str: "Good ${getTime()}",
                            size: 16,
                            color: primary,
                            weight: regular,
                            alignment: left,
                          ),
                          FutureBuilder<String>(
                            future: _studentNameService.getStudentName(
                              nrp: user.currentUser!.email
                                  .toString()
                                  .split("@")[0],
                            ),
                            builder: (context, snapshot) {
                              return TextWidget(
                                str:
                                    "${titleCase(snapshot.data.toString())} 👋",
                                size: 24,
                                color: primary,
                                weight: bold,
                                alignment: left,
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            str: "Welcome to Pantra!",
                            size: 20,
                            color: primary,
                            weight: bold,
                            alignment: left,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextWidget(
                            str:
                                "Pantra (Panitia Petra) aims to be able to help students maximize the potential and talents of interest in the campus environment.",
                            size: 16,
                            color: primary,
                            weight: regular,
                            alignment: left,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/images/student.jpg',
                        fit: BoxFit.contain,
                        width: MediaQuery.of(context).size.width * 0.4,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 5),
                  child: TextWidget(
                    str: "Explore Events",
                    size: 20,
                    color: primary,
                    weight: bold,
                    alignment: left,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NavBar(
                          pageIndex: 1,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 5,
                    color: light_secondary,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                  str:
                                      "Are you a student who is looking for SKKK for organizations and committees?",
                                  size: 18,
                                  color: primary,
                                  weight: bold,
                                  alignment: left,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextWidget(
                                  str:
                                      "Check out the list of exciting organizing events for you now!",
                                  size: 16,
                                  color: primary,
                                  weight: regular,
                                  alignment: left,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              'assets/images/explore_events.jpg',
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width * 0.35,
                              height: 170,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 5),
                  child: TextWidget(
                    str: "Explore Petranesians",
                    size: 20,
                    color: primary,
                    weight: bold,
                    alignment: right,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NavBar(
                          pageIndex: 2,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 5,
                    color: light_secondary,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              'assets/images/explore_petranesians.jpg',
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width * 0.35,
                              height: 180,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                TextWidget(
                                  str:
                                      "Are you a student currently looking for members for a committee event?",
                                  size: 18,
                                  color: primary,
                                  weight: bold,
                                  alignment: right,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextWidget(
                                  str:
                                      "Find experienced students according to your criteria and type now!",
                                  size: 16,
                                  color: primary,
                                  weight: regular,
                                  alignment: right,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
