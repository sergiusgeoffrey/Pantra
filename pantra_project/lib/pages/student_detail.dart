import 'package:flutter/material.dart';
import 'package:pantra_project/models/student.dart';
import 'package:pantra_project/models/student_creds.dart';
import 'package:pantra_project/services/student.dart';
import 'package:pantra_project/services/student_creds.dart';

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

  @override
  void initState() {
    super.initState();
    _studentDetails = _studentDetailService.getAllData(nrp: widget.nrp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Center(
            child: Text(
              "Student Details",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.05,
                fontWeight: FontWeight.bold,
                color: const Color.fromRGBO(60, 108, 180, 1),
              ),
            ),
          ),
          Container(
            //Foto
            height: MediaQuery.of(context).size.height * 0.8,
            child: FutureBuilder<List<StudentCreds>>(
              future: _studentDetails,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    child: Row(
                      children: [
                        Text(
                          "Nama - NRP:",
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.03,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromRGBO(60, 108, 180, 1)),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                        Text(
                          snapshot.data![0].name +
                              " - " +
                              snapshot.data![0].nrp,
                        ),
                      ],
                    ),
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
          ),
          //Nama
          //NRP
          //Jurusan Angkatan
          //Porto
          //Pengalaman card/popup
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
        ]),
      ),
    );
  }
}
