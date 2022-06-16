import 'package:flutter/material.dart';
import 'package:pantra_project/models/student_creds.dart';
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
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: SingleChildScrollView(
              child: FutureBuilder<List<StudentCreds>>(
                future: _studentDetails,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.6,
                            width: MediaQuery.of(context).size.width * 0.65,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                snapshot.data![0].photoFilepath,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          //Nama
                          //NRP
                          Text(
                            "Nama - NRP:",
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.02,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromRGBO(0,0,0, 1)),
                          ),
                          Text(
                            "${snapshot.data![0].name} - ${snapshot.data![0].nrp}",
                            style:TextStyle(
                              fontSize:
                                    MediaQuery.of(context).size.height * 0.02,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromRGBO(60, 108, 180, 1))
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          //Jurusan
                          Text(
                            "Jurusan:",
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.02,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromRGBO(0,0,0, 1)),
                          ),
                          Text(
                            snapshot.data![0].jurusan,
                            style:TextStyle(
                              fontSize:
                                    MediaQuery.of(context).size.height * 0.02,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromRGBO(60, 108, 180, 1))
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                           //Angkatan
                          Text(
                            "Angkatan:",
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.02,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromRGBO(0,0,0, 1)),
                          ),
                          Text(
                            snapshot.data![0].angkatan.toString(),
                            style:TextStyle(
                              fontSize:
                                    MediaQuery.of(context).size.height * 0.02,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromRGBO(60, 108, 180, 1))
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          //Porto
                          Text(
                            "Portofolio:",
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.02,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromRGBO(0,0,0, 1)),
                          ),
                          Text(
                            "TODO NEXT",
                            style:TextStyle(
                              fontSize:
                                    MediaQuery.of(context).size.height * 0.02,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromRGBO(60, 108, 180, 1))
                          ),
                          //Pengalaman card/popup
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
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
        ]),
      ),
    );
  }
}
