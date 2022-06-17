import 'package:flutter/material.dart';
import 'package:pantra_project/models/student_creds.dart';
import 'package:pantra_project/models/student_testimonial.dart';
import 'package:pantra_project/services/student_creds.dart';
import 'package:pantra_project/services/student_testimonial.dart';
import 'package:pantra_project/utils/color.dart';
import 'package:url_launcher/url_launcher.dart';

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
          title: Text(
            'Experience',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.03,
                fontWeight: FontWeight.bold,
                color: primary),
          ),
          content: Text(
            pengalaman,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.02,
                fontWeight: FontWeight.bold,
                color: primary),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: primary)),
              onPressed: () {
                setState(() {});
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
      heightposter = (MediaQuery.of(context).size.width * 0.9);
    } else {
      heightposter = (MediaQuery.of(context).size.height * 0.9);
    }
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Flexible(
                  flex: 4,
                  fit: FlexFit.tight,
                  child: Text(
                    "Student Details",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.04,
                      fontWeight: FontWeight.bold,
                      color: primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: secondary,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width,
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
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              //Nama
                              //NRP
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: primary,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                        MediaQuery.of(context).size.height *
                                            0.05),
                                  ),
                                  color: Color.fromRGBO(255, 255, 255, 0.4),
                                ),
                                margin: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.height * 0.05,
                                    0,
                                    MediaQuery.of(context).size.height * 0.05,
                                    0),
                                padding: EdgeInsets.fromLTRB(
                                    0,
                                    MediaQuery.of(context).size.height * 0.05,
                                    0,
                                    MediaQuery.of(context).size.height * 0.05),
                                child: Column(
                                  children: [
                                    Text(
                                      "Nama - NRP:",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.03,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              const Color.fromRGBO(0, 0, 0, 1)),
                                    ),
                                    Text(
                                        textAlign: TextAlign.center,
                                        "${snapshot.data![0].name} - ${snapshot.data![0].nrp}",
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02,
                                            fontWeight: FontWeight.bold,
                                            color: const Color.fromRGBO(
                                                60, 108, 180, 1))),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                    ),
                                    //Jurusan
                                    Text(
                                      textAlign: TextAlign.center,
                                      "Jurusan:",
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.03,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              const Color.fromRGBO(0, 0, 0, 1)),
                                    ),
                                    Text(snapshot.data![0].jurusan,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02,
                                            fontWeight: FontWeight.bold,
                                            color: const Color.fromRGBO(
                                                60, 108, 180, 1))),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                    ),
                                    //Angkatan
                                    Text(
                                      textAlign: TextAlign.center,
                                      "Angkatan:",
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.03,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              const Color.fromRGBO(0, 0, 0, 1)),
                                    ),
                                    Text(snapshot.data![0].angkatan.toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02,
                                            fontWeight: FontWeight.bold,
                                            color: const Color.fromRGBO(
                                                60, 108, 180, 1))),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                    ),
                                    //Porto

                                    //if snapshot has portofolio
                                    if (snapshot.data![0].portfolio != null)
                                      Text(
                                        textAlign: TextAlign.center,
                                        "Portofolio:",
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03,
                                            fontWeight: FontWeight.bold,
                                            color: const Color.fromRGBO(
                                                0, 0, 0, 1)),
                                      ),

                                    //if snapshot has no portofolio
                                    if (snapshot.data![0].portfolio != null)
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 0, 8, 0),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              // ignore: prefer_const_constructors
                                              primary: primary),
                                          onPressed: () async {
                                            if (await canLaunchUrl(Uri.parse(
                                                snapshot.data![0].portfolio
                                                    .toString()))) {
                                              await launchUrl(Uri.parse(snapshot
                                                  .data![0].portfolio
                                                  .toString()));
                                            }
                                          },
                                          child: Text(
                                            snapshot.data![0].portfolio
                                                .toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.02,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    if (snapshot.data![0].portfolio != null)
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02,
                                      ),
                                    //Pengalaman card/popup
                                    Text(
                                      textAlign: TextAlign.center,
                                      "Experience:",
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.03,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              const Color.fromRGBO(0, 0, 0, 1)),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        _showDivisionDialog(
                                            snapshot.data![0].pengalaman
                                                .toString(),
                                            heightposter);
                                      },
                                      child: Text(
                                        "See Experience",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
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
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.02,
                                  ),
                                  Text(
                                    textAlign: TextAlign.center,
                                    snapshot.data![index].event,
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            const Color.fromRGBO(0, 0, 0, 1)),
                                  ),
                                  Text(snapshot.data![index].testimonial,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02,
                                          fontWeight: FontWeight.bold,
                                          color: const Color.fromRGBO(
                                              60, 108, 180, 1))),
                                ],
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        } else {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: const Center(
                              child: Text(
                                "No testimonials",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 230, 37, 12),
                                ),
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
