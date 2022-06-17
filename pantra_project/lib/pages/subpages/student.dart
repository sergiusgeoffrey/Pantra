// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pantra_project/models/student.dart';
import 'package:pantra_project/pages/student_detail.dart';
import 'package:pantra_project/services/student.dart';
import 'package:pantra_project/utils/colors.dart';
import 'package:pantra_project/widget/text.dart';

class StudentPage extends StatefulWidget {
  const StudentPage({Key? key}) : super(key: key);

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  final StudentService _studentService = StudentService();
  late Future<List<Student>> _students;

  // TODO: add filters to update these values
  int year = 0;
  String experience = "";
  String faculty = "";
  String major = "";

  @override
  void initState() {
    super.initState();
    _students = _studentService.getAllData(
      studentYear: year,
      experience: experience,
      faculty: faculty,
      major: major,
    );
  }

  Color blue = const Color.fromRGBO(60, 108, 180, 1);
  Color black = const Color.fromRGBO(0, 0, 0, 1);
  TextAlign left = TextAlign.left;
  TextAlign center = TextAlign.center;
  FontWeight bold = FontWeight.bold;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          TextWidget(
              str: "Explore Petranesians",
              size: MediaQuery.of(context).size.height * 0.04,
              color: blue,
              weight: bold,
              alignment: center),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          TextWidget(
              str: "Click on Petranesian to see more details!",
              size: MediaQuery.of(context).size.height * 0.02,
              color: black,
              weight: bold,
              alignment: center),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          FutureBuilder<List<Student>>(
            future: _students,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                List<Student> students = snapshot.data!;
                return CarouselSlider(
                  options: CarouselOptions(
                      height: 500,
                      viewportFraction: MediaQuery.of(context).size.width >
                              MediaQuery.of(context).size.height
                          ? 0.3
                          : 0.6,
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 300),
                      autoPlay: true,
                      enlargeCenterPage: false,
                      enableInfiniteScroll: false,
                      disableCenter: true),
                  items: students
                      .map(
                        (item) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.height * 0.05,
                              0,
                              MediaQuery.of(context).size.height * 0.05,
                              0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 250,
                                height: 300,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return StudentDetail(nrp: item.nrp);
                                        },
                                      ),
                                    );
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: item.photoFilepath != null
                                        ? FadeInImage.assetNetwork(
                                            placeholder: "images/ukp.png",
                                            image: item.photoFilepath,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.network(
                                            'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png',
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextWidget(
                                  str: item.nama,
                                  size: 17,
                                  color: primary,
                                  weight: bold,
                                  alignment: left),
                              TextWidget(
                                  str: item.angkatan.toString(),
                                  size: 15,
                                  color: black,
                                  weight: bold,
                                  alignment: left),
                              TextWidget(
                                  str: item.program,
                                  size: 15,
                                  color: black,
                                  weight: bold,
                                  alignment: left),
                              TextWidget(
                                  str: item.fakultas,
                                  size: 15,
                                  color: black,
                                  weight: bold,
                                  alignment: left),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                );
              }
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
        ],
      ),
    );
  }
}
