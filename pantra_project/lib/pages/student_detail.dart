import 'package:flutter/material.dart';
import 'package:pantra_project/models/student.dart';
import 'package:pantra_project/models/student_creds.dart';
import 'package:pantra_project/services/student.dart';
import 'package:pantra_project/services/student_creds.dart';

class StudentDetail extends StatefulWidget {
  final String nrp;
  final String name;
  const StudentDetail({Key? key,required this.nrp,required this.name}) : super(key: key);

  @override
  State<StudentDetail> createState() => _StudentDetailState();
}

class _StudentDetailState extends State<StudentDetail> {
  final StudentCredsService _studentCredsService = StudentCredsService();
  late Future<List<StudentCreds>> _studentCreds;

  @override
  void initState() {
    super.initState();
    _studentCreds = _studentCredsService.getAllData(name: widget.name,nrp: widget.nrp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Center(
                child: Text(
                  "Student Details",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.05,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromRGBO(60, 108, 180, 1)),
                ),
              ),
              //Foto
              Text(
                "Nama - NRP:",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.03,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromRGBO(60, 108, 180, 1)),
              ),
              //Nama
              //NRP
              Text(
                "Jurusan - Angkatan:",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.03,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromRGBO(60, 108, 180, 1)),
              ),
              //Jurusan Angkatan
              Text(
                "Portofolio:",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.03,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromRGBO(60, 108, 180, 1)),
              ),
              //Porto
              Text(
                "Pengalaman Panitia:",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.03,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromRGBO(60, 108, 180, 1)),
              ),
              //Pengalaman card/popup
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),

            ]
          ),
      ),
    );  
  }
}
