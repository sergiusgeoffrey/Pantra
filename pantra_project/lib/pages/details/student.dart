import 'package:flutter/material.dart';
import 'package:pantra_project/models/student_creds.dart';
import 'package:pantra_project/models/student_testimonial.dart';
import 'package:pantra_project/services/student_creds.dart';
import 'package:pantra_project/services/student_testimonial.dart';
import 'package:pantra_project/utils/color.dart';
import 'package:pantra_project/widget/student_details.dart';
import 'package:pantra_project/widget/text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pantra_project/utils/alignment.dart';
import 'package:pantra_project/utils/font_weight.dart';

class StudentDetail extends StatefulWidget {
  final String nrp;
  const StudentDetail({
    Key? key,
    required this.nrp,
  }) : super(key: key);

  @override
  State<StudentDetail> createState() => _StudentDetailState();
}

class _StudentDetailState extends State<StudentDetail> {
  final StudentCredsService _studentDetailService = StudentCredsService();
  late Future<List<StudentCreds>> _studentDetails;

  final StudentTestimonialService _studentTestimonialService =
      StudentTestimonialService();
  late Future<List<StudentTestimonial>> _studentTestimonials;

  @override
  void initState() {
    super.initState();

    _studentDetails = _studentDetailService.getAllData(
      nrp: widget.nrp,
    );

    _studentTestimonials = _studentTestimonialService.getAllData(
      nrp: widget.nrp,
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
                str: 'CLOSE',
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
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.075,
            width: MediaQuery.of(context).size.width,
            color: secondary,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    color: primary,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Flexible(
                  flex: 4,
                  fit: FlexFit.tight,
                  child: TextWidget(
                    str: "Student Details",
                    size: MediaQuery.of(context).size.height * 0.03,
                    color: primary,
                    weight: bold,
                    alignment: center,
                  ),
                ),
              ],
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
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                              ),
                              SizedBox(
                                width: heightposter,
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
                                    MediaQuery.of(context).size.height * 0.05,
                                    0,
                                    MediaQuery.of(context).size.height * 0.05,
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
                                        isiSnapshot: snapshot.data![0].name),
                                    StudentDetailWidget(
                                        strJudul: 'NRP',
                                        isiSnapshot: snapshot.data![0].nrp),
                                    StudentDetailWidget(
                                        strJudul: 'Major',
                                        isiSnapshot: snapshot.data![0].jurusan),
                                    StudentDetailWidget(
                                        strJudul: 'Batch',
                                        isiSnapshot: snapshot.data![0].angkatan
                                            .toString()),
                                    if (snapshot.data![0].portfolio != null)
                                      TextWidget(
                                        str: 'Portfolio',
                                        size:
                                            MediaQuery.of(context).size.height *
                                                0.02,
                                        color: black,
                                        weight: bold,
                                        alignment: center,
                                      ),
                                    if (snapshot.data![0].portfolio != null)
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 0, 8, 0),
                                        child: ElevatedButton(
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
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                      ),
                                    TextWidget(
                                      str: 'Experiences',
                                      size: MediaQuery.of(context).size.height *
                                          0.02,
                                      color: black,
                                      weight: bold,
                                      alignment: center,
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
                                      child: TextWidget(
                                        str: "See Experiences",
                                        size:
                                            MediaQuery.of(context).size.height *
                                                0.025,
                                        color: primary,
                                        weight: bold,
                                        alignment: center,
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
                                bottom:
                                    MediaQuery.of(context).size.height * 0.05),
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: primary,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05),
                                        ),
                                        color: grey,
                                      ),
                                      margin: EdgeInsets.fromLTRB(
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                          0,
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                          0),
                                      padding: EdgeInsets.fromLTRB(
                                          MediaQuery.of(context).size.width *
                                              0.05,
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                          MediaQuery.of(context).size.width *
                                              0.05,
                                          MediaQuery.of(context).size.height *
                                              0.05),
                                      child: Column(
                                        children: [
                                          TextWidget(
                                              str: snapshot.data![index].event,
                                              size: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.03,
                                              color: black,
                                              weight: bold,
                                              alignment: center),
                                          SizedBox(height: 8),
                                          TextWidget(
                                              str: snapshot
                                                  .data![index].testimonial,
                                              size: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.03,
                                              color: primary,
                                              weight: bold,
                                              alignment: justify),
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
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: Center(
                              child: TextWidget(
                                str: "No Testimonials Found",
                                size: 16,
                                color: red,
                                weight: bold,
                                alignment: center,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
