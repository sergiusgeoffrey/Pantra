import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
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
  // final user = FirebaseAuth.instance;

  // final StudentNameService _studentNameService = StudentNameService();
  // late Future<String> _futureStudentName;

  // @override
  // void initState() {
  //   super.initState();

  //   _futureStudentName = _studentNameService.getStudentName(
  //     nrp: user.currentUser!.email.toString().split("@")[0],
  //   );

  //   Future(() {
  //     _futureStudentName.then((value) {
  //       showDialog(
  //         context: context,
  //         barrierDismissible: true,
  //         builder: (context) => AlertDialog(
  //           title: TextWidget(
  //             str: "Welcome back, $value! 👋",
  //             size: 20,
  //             color: primary,
  //             weight: bold,
  //             alignment: center,
  //           ),
  //         ),
  //       );
  //     });
  //   });
  // }

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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          str: "Good ${getTime()}",
                          size: 16,
                          color: primary,
                          weight: regular,
                          alignment: left,
                        ),
                        TextWidget(
                          str: "name! 👋",
                          size: 24,
                          color: primary,
                          weight: bold,
                          alignment: left,
                        ),
                      ],
                    ),
                    Image.network(
                      'https://www.petra.ac.id/img/ukpetra-logo-text.0f91758d.png',
                      fit: BoxFit.contain,
                      width: 130,
                      height: 40,
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
                    // Navigator.pushNamed(context, '/events');
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
                            child: Image.network(
                              'https://instagram.fcgk30-1.fna.fbcdn.net/v/t51.2885-15/66472250_154684382282483_5718420059442705636_n.jpg?stp=dst-jpg_e35&_nc_ht=instagram.fcgk30-1.fna.fbcdn.net&_nc_cat=111&_nc_ohc=XTF3ZJGgCfcAX-limrD&edm=ALQROFkBAAAA&ccb=7-5&ig_cache_key=MjEwNDYyMTMzNjI3MTA4MDg3OQ%3D%3D.2-ccb7-5&oh=00_AT-HvMbPlIQjjCWBzFe3pMvqEafYb4YbQ84FG7AKDUhJqw&oe=62B7AA6B&_nc_sid=30a2ef',
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
                    // Navigator.pushNamed(context, '/events');
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
                            child: Image.network(
                              'https://instagram.fcgk30-1.fna.fbcdn.net/v/t51.2885-15/81127625_2528121307460324_3975439623927978525_n.jpg?stp=dst-jpg_e35_s1080x1080&_nc_ht=instagram.fcgk30-1.fna.fbcdn.net&_nc_cat=108&_nc_ohc=zk2RrzJiWc8AX8NjkML&edm=AOQ1c0wBAAAA&ccb=7-5&oh=00_AT_igLZDka18GcBXMvTJNRPJqO09mXE3x8Y-gOymecLnNQ&oe=62B7B963&_nc_sid=8fd12b',
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
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
