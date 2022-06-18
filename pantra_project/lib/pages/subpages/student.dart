import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pantra_project/models/string_obj.dart';
import 'package:pantra_project/models/student.dart';
import 'package:pantra_project/pages/details/student.dart';
import 'package:pantra_project/services/student.dart';
import 'package:pantra_project/services/student_batch.dart';
import 'package:pantra_project/services/student_faculty.dart';
import 'package:pantra_project/services/student_major.dart';
import 'package:pantra_project/utils/color.dart';
import 'package:pantra_project/utils/division.dart';
import 'package:pantra_project/widget/text.dart';
import 'package:pantra_project/utils/alignment.dart';
import 'package:pantra_project/utils/font_weight.dart';

class StudentPage extends StatefulWidget {
  const StudentPage({Key? key}) : super(key: key);

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  final StudentService _studentService = StudentService();
  late Future<List<Student>> _futureStudents;

  final StudentBatchService _studentBatchService = StudentBatchService();
  late Future<List<StringObj>> _futureStudentBatch;
  final GlobalKey<FormFieldState> _keyBatch = GlobalKey<FormFieldState>();

  final StudentFacultyService _studentFacultyService = StudentFacultyService();
  late Future<List<StringObj>> _futureStudentFaculty;
  final GlobalKey<FormFieldState> _keyFaculty = GlobalKey<FormFieldState>();

  final StudentMajorService _studentMajorService = StudentMajorService();
  late Future<List<StringObj>> _futureStudentMajor;
  final GlobalKey<FormFieldState> _keyMajor = GlobalKey<FormFieldState>();

  late Future<List<StringObj>> _futureStudentExperience;
  final GlobalKey<FormFieldState> _keyExperience = GlobalKey<FormFieldState>();

  bool showResetFilterButton = false;

  int batch = 0;
  String experience = "";
  String faculty = "";
  String major = "";

  @override
  void initState() {
    super.initState();

    _futureStudents = _studentService.getAllData(
      studentBatch: batch,
      experience: experience,
      faculty: faculty,
      major: major,
    );

    // FILTERS
    _futureStudentBatch = _studentBatchService.getAllData();
    _futureStudentFaculty = _studentFacultyService.getAllData();
    _futureStudentMajor = _studentMajorService.getAllData();
    _futureStudentExperience = getDivision();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            TextWidget(
                str: "Explore Petranesians",
                size: MediaQuery.of(context).size.height * 0.04,
                color: primary,
                weight: bold,
                alignment: center),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            TextWidget(
                str: "Click on Petranesian to see more details!",
                size: MediaQuery.of(context).size.height * 0.02,
                color: primary,
                weight: bold,
                alignment: center),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            filterStudent(
              "experience",
              _futureStudentExperience,
              Icons.work_history,
              _keyExperience,
            ),
            filterStudent(
              "batch",
              _futureStudentBatch,
              Icons.calendar_month,
              _keyBatch,
            ),
            filterStudent(
              "faculty",
              _futureStudentFaculty,
              Icons.school,
              _keyFaculty,
            ),
            filterStudent(
              "major",
              _futureStudentMajor,
              Icons.code,
              _keyMajor,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            showResetFilterButton
                ? Container(
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.05),
                    child: SizedBox(
                      width: 150,
                      height: 50,
                      child: showResetFilterButton
                          ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: secondary,
                              ),
                              child: const Text(
                                "Reset Filters",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                setState(
                                  () {
                                    batch = 0;
                                    faculty = "";
                                    major = "";
                                    experience = "";

                                    _futureStudents =
                                        _studentService.getAllData(
                                      studentBatch: batch,
                                      experience: experience,
                                      faculty: faculty,
                                      major: major,
                                    );

                                    _keyExperience.currentState?.reset();
                                    _keyBatch.currentState?.reset();
                                    _keyFaculty.currentState?.reset();
                                    _keyMajor.currentState?.reset();

                                    showResetFilterButton = false;
                                  },
                                );
                              },
                            )
                          : const SizedBox(
                              width: 0,
                              height: 0,
                            ),
                    ),
                  )
                : const SizedBox(
                    width: 0,
                    height: 0,
                  ),
            FutureBuilder<List<Student>>(
              future: _futureStudents,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  List<Student> students = snapshot.data!;
                  return CarouselSlider(
                    options: CarouselOptions(
                        height: 500,
                        viewportFraction: MediaQuery.of(context).size.width >
                                MediaQuery.of(context).size.height
                            ? 0.2
                            : 0.7,
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
                                              "images/ukp.png",
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
                                    size: 19,
                                    color: primary,
                                    weight: bold,
                                    alignment: center),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextWidget(
                                    str: item.fakultas,
                                    size: 17,
                                    color: black,
                                    weight: bold,
                                    alignment: center),
                                TextWidget(
                                    str: item.program,
                                    size: 17,
                                    color: black,
                                    weight: bold,
                                    alignment: center),
                                TextWidget(
                                    str: item.angkatan.toString(),
                                    size: 17,
                                    color: black,
                                    weight: bold,
                                    alignment: center),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  );
                } else {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: const Center(
                      child: Text(
                        "No students found!",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: red,
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
          ],
        ),
      ),
    );
  }

  Widget filterStudent(element, futureStringObj, icon, key) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05),
      child: FutureBuilder<List<StringObj>>(
        future: futureStringObj,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return DropdownButtonFormField<StringObj>(
              key: key,
              decoration: InputDecoration(
                labelText: "Filter student by $element",
                labelStyle: const TextStyle(
                  color: primary,
                ),
                prefixIcon: Icon(
                  icon,
                  color: primary,
                ),
              ),
              menuMaxHeight: 500,
              icon: const Icon(
                Icons.arrow_drop_down,
                color: primary,
              ),
              onChanged: (value) {
                setState(() {
                  if (element == "batch") batch = int.parse(value!.data);
                  if (element == "faculty") faculty = value!.data;
                  if (element == "major") major = value!.data;
                  if (element == "experience") experience = value!.data;

                  _futureStudents = _studentService.getAllData(
                    studentBatch: batch,
                    faculty: faculty,
                    major: major,
                    experience: experience,
                  );

                  showResetFilterButton = true;
                });
              },
              items: snapshot.data?.map<DropdownMenuItem<StringObj>>(
                (StringObj value) {
                  return DropdownMenuItem<StringObj>(
                    value: value,
                    child: Text(value.data),
                  );
                },
              ).toList(),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
