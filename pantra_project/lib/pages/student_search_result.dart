import 'package:flutter/material.dart';
import 'package:pantra_project/models/student_creds.dart';
import 'package:pantra_project/models/student_testimonial.dart';
import 'package:pantra_project/pages/student_detail.dart';
import 'package:pantra_project/services/student_creds.dart';
import 'package:pantra_project/utils/alignment.dart';
import 'package:pantra_project/utils/color.dart';

class StudentSearchResult extends StatefulWidget {
  final String nrp;
  final String name;

  // NOTE: use only one either nrp or name (don't combine them)
  const StudentSearchResult({
    Key? key,
    this.nrp = "", // this is a default value
    this.name = "angel", // this is a default value
  }) : super(key: key);

  @override
  State<StudentSearchResult> createState() => _StudentDetailState();
}

class _StudentDetailState extends State<StudentSearchResult> {
  final StudentCredsService _studentService = StudentCredsService();
  late Future<List<StudentCreds>> _studentDetails;

  String nrp = "";
  String name = "";

  @override
  void initState() {
    super.initState();

    _studentDetails = _studentService.getAllData(
      nrp: widget.nrp,
      name: widget.name,
    );

    setState(() {
      nrp = widget.nrp;
      name = widget.name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Text(
              "Student Search Results\n\"$name$nrp\"",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: primary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 25,
            ),
            FutureBuilder<List<StudentCreds>>(
              future: _studentDetails,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          if (index == 0)
                            Text(
                              "${snapshot.data!.length} results found",
                              textAlign: TextAlign.start,
                            ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return StudentDetail(
                                          nrp: snapshot.data![index].nrp);
                                    },
                                  ),
                                );
                              },
                              child: Card(
                                elevation: 5,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot.data![index].name,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            snapshot.data![index].nrp
                                                .toUpperCase(),
                                            style: const TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                          Text(
                                            snapshot.data![index].jurusan
                                                .split(" - ")[0],
                                            style: const TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                          Text(
                                            snapshot.data![index].jurusan
                                                .split(" - ")[1],
                                            style: const TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                          Text(
                                            snapshot.data![index].angkatan
                                                .toString(),
                                            style: const TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                      snapshot.data![index].photoFilepath !=
                                              null
                                          ? FadeInImage.assetNetwork(
                                              placeholder: "images/ukp.png",
                                              image: snapshot
                                                  .data![index].photoFilepath,
                                              fit: BoxFit.cover,
                                              width: 100,
                                              height: 100,
                                            )
                                          : Image.network(
                                              "images/ukp.png",
                                              fit: BoxFit.cover,
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else {
                  // TODO: position this text vertically in the center of the screen
                  return Text(
                    "No results found for\n\"$nrp$name\"\n\nPlease make sure the student you are looking for has a Curriculum Vitae at RE-ACH.",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color.fromARGB(255, 230, 37, 12),
                    ),
                    textAlign: center,
                  );
                }
              },
            ),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
