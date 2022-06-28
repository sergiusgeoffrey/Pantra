import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pantra_project/models/student_creds.dart';
import 'package:pantra_project/models/student_testimonial.dart';
import 'package:pantra_project/services/student/student_creds.dart';
import 'package:pantra_project/services/student/student_testimonial.dart';
import 'package:pantra_project/utils/alignment.dart';
import 'package:pantra_project/utils/color.dart';
import 'package:pantra_project/utils/font_weight.dart';
import 'package:pantra_project/widget/student_details.dart';
import 'package:pantra_project/widget/text.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountDetail extends StatefulWidget {
  const AccountDetail({Key? key}) : super(key: key);

  @override
  State<AccountDetail> createState() => _AccountDetailState();
}

class _AccountDetailState extends State<AccountDetail> {
  final StudentCredsService _studentDetailService = StudentCredsService();
  late Future<List<StudentCreds>> _studentDetails;

  final StudentTestimonialService _studentTestimonialService =
      StudentTestimonialService();
  late Future<List<StudentTestimonial>> _studentTestimonials;

  final user = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    _studentDetails = _studentDetailService.getAllData(
        nrp: user.currentUser!.email.toString().split('@')[0]);

    _studentTestimonials = _studentTestimonialService.getAllData(
      nrp: user.currentUser!.email.toString().split('@')[0],
    );
  }

  Future<void> _showDivisionDialog(
      String pengalaman, double heightposter) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: secondary,
          title: TextWidget(
            str: 'View Experiences',
            size: MediaQuery.of(context).size.height * 0.025,
            color: primary,
            weight: bold,
            alignment: center,
          ),
          content: TextWidget(
            str: pengalaman,
            size: 18,
            color: black,
            weight: regular,
            alignment: center,
          ),
          actions: <Widget>[
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              child: TextWidget(
                str: 'Close',
                size: 14,
                color: white,
                weight: bold,
                alignment: center,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double heightposter = 0;
    if (MediaQuery.of(context).size.height >
        MediaQuery.of(context).size.width) {
      heightposter = (MediaQuery.of(context).size.width * 0.75);
    } else {
      heightposter = (MediaQuery.of(context).size.height * 0.75);
    }
    return Container(
      color: secondary,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: background,
          body: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.075,
                width: MediaQuery.of(context).size.width,
                color: secondary,
                alignment: Alignment.center,
                child: TextWidget(
                  str: "Your Details",
                  size: MediaQuery.of(context).size.height * 0.03,
                  color: primary,
                  weight: bold,
                  alignment: center,
                ),
              ),
              ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        FutureBuilder<List<StudentCreds>>(
                          future: _studentDetails,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Column(
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                  ),
                                  SizedBox(
                                    width: heightposter,
                                    // height: MediaQuery.of(context).size.height * 0.6,
                                    // width: MediaQuery.of(context).size.width * 0.65,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        snapshot.data![0].photoFilepath,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.height *
                                            0.05,
                                        0,
                                        MediaQuery.of(context).size.height *
                                            0.05,
                                        0),
                                    padding: EdgeInsets.fromLTRB(
                                      0,
                                      MediaQuery.of(context).size.height * 0.05,
                                      0,
                                      MediaQuery.of(context).size.height * 0.05,
                                    ),
                                    child: Column(
                                      children: [
                                        StudentDetailWidget(
                                          strJudul: 'Name',
                                          isiSnapshot: snapshot.data![0].name,
                                        ),
                                        StudentDetailWidget(
                                          strJudul: 'NRP',
                                          isiSnapshot: snapshot.data![0].nrp
                                              .toUpperCase(),
                                        ),
                                        StudentDetailWidget(
                                          strJudul: 'Major',
                                          isiSnapshot: snapshot.data![0].jurusan
                                              .split(" - ")[1],
                                        ),
                                        StudentDetailWidget(
                                            strJudul: 'Batch',
                                            isiSnapshot: snapshot
                                                .data![0].angkatan
                                                .toString()),
                                        if (snapshot.data![0].portfolio != null)
                                          TextWidget(
                                            str: 'Portfolio',
                                            size: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02,
                                            color: black,
                                            weight: bold,
                                            alignment: center,
                                          ),
                                        if (snapshot.data![0].portfolio != null)
                                          const SizedBox(
                                            height: 5,
                                          ),
                                        if (snapshot.data![0].portfolio != null)
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: secondary,
                                            ),
                                            onPressed: () async {
                                              if (await canLaunchUrl(
                                                Uri.parse(
                                                  snapshot.data![0].portfolio
                                                      .toString(),
                                                ),
                                              )) {
                                                await launchUrl(
                                                  Uri.parse(
                                                    snapshot.data![0].portfolio
                                                        .toString(),
                                                  ),
                                                );
                                              }
                                            },
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0,
                                                  MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.01,
                                                  0,
                                                  MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.01),
                                              child: TextWidget(
                                                str: "See Portfolio",
                                                size: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.025,
                                                color: primary,
                                                weight: bold,
                                                alignment: center,
                                              ),
                                            ),
                                          ),
                                        if (snapshot.data![0].portfolio != null)
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03,
                                          ),
                                        TextWidget(
                                          str: 'Experiences',
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02,
                                          color: black,
                                          weight: bold,
                                          alignment: center,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: secondary,
                                          ),
                                          onPressed: () {
                                            _showDivisionDialog(
                                              snapshot.data![0].pengalaman
                                                  .toString(),
                                              heightposter,
                                            );
                                          },
                                          child: Container(
                                            padding: EdgeInsets.fromLTRB(
                                                0,
                                                MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.01,
                                                0,
                                                MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.01),
                                            child: TextWidget(
                                              str: "See Experiences",
                                              size: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.025,
                                              color: primary,
                                              weight: bold,
                                              alignment: center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            } else if (snapshot.hasError) {
                              return Text("${snapshot.error}");
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                        Container(
                          height: 2,
                          width: MediaQuery.of(context).size.width * 0.9,
                          color: Colors.purple,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextWidget(
                          str: "Testimonials",
                          size: MediaQuery.of(context).size.height * 0.03,
                          color: black,
                          weight: bold,
                          alignment: center,
                        ),
                        FutureBuilder<List<StudentTestimonial>>(
                          future: _studentTestimonials,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasData &&
                                snapshot.data!.isNotEmpty) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).size.height *
                                        0.05),
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: <Widget>[
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02,
                                        ),
                                        Container(
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                            color: secondary,
                                          ),
                                          margin: EdgeInsets.fromLTRB(
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                            0,
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                            0,
                                          ),
                                          padding: EdgeInsets.fromLTRB(
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                            MediaQuery.of(context).size.height *
                                                0.02,
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                            MediaQuery.of(context).size.height *
                                                0.02,
                                          ),
                                          child: Column(
                                            children: [
                                              TextWidget(
                                                str:
                                                    snapshot.data![index].event,
                                                size: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.025,
                                                color: primary,
                                                weight: bold,
                                                alignment: center,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                height: 2,
                                                color: Colors.purple,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              TextWidget(
                                                str: snapshot
                                                    .data![index].testimonial,
                                                size: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.02,
                                                color: black,
                                                weight: regular,
                                                alignment: left,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Text("${snapshot.error}");
                            } else {
                              return SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                child: Center(
                                  child: TextWidget(
                                    str: "No testimonials",
                                    size: MediaQuery.of(context).size.height *
                                        0.02,
                                    color: red,
                                    weight: regular,
                                    alignment: center,
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
