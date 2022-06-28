import 'package:flutter/material.dart';
import 'package:pantra_project/models/student_creds.dart';
import 'package:pantra_project/pages/details/student.dart';
import 'package:pantra_project/services/student/student_creds.dart';
import 'package:pantra_project/utils/alignment.dart';
import 'package:pantra_project/utils/color.dart';
import 'package:pantra_project/utils/font_weight.dart';
import 'package:pantra_project/widget/text.dart';

class StudentSearchResult extends StatefulWidget {
  final String name;

  const StudentSearchResult({
    Key? key,
    this.name = "handrian",
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
      name: widget.name,
    );

    setState(() {
      name = widget.name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: background,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: background,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Row(
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
                        str: 'Student Search Results',
                        size: MediaQuery.of(context).size.height * 0.03,
                        color: primary,
                        weight: bold,
                        alignment: center,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
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
                                  "${snapshot.data!.length} result(s) found for \"$name\"",
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
                                    color: light_secondary,
                                    elevation: 5,
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                TextWidget(
                                                    str: snapshot
                                                        .data![index].name,
                                                    color: primary,
                                                    size: 20,
                                                    weight: bold,
                                                    alignment: left),
                                                TextWidget(
                                                    str: snapshot
                                                        .data![index].nrp
                                                        .toUpperCase(),
                                                    color: black,
                                                    size: 18,
                                                    weight: bold,
                                                    alignment: left),
                                                TextWidget(
                                                    str: snapshot
                                                        .data![index].jurusan
                                                        .split(" - ")[0],
                                                    color: black,
                                                    size: 18,
                                                    weight: regular,
                                                    alignment: left),
                                                TextWidget(
                                                    str: snapshot
                                                        .data![index].jurusan
                                                        .split(" - ")[1],
                                                    color: black,
                                                    size: 18,
                                                    weight: regular,
                                                    alignment: left),
                                                TextWidget(
                                                    str: snapshot
                                                        .data![index].angkatan
                                                        .toString(),
                                                    color: black,
                                                    size: 18,
                                                    weight: regular,
                                                    alignment: left),
                                              ],
                                            ),
                                          ),
                                          snapshot.data![index].photoFilepath !=
                                                  null
                                              ? Flexible(
                                                  flex: 1,
                                                  child:
                                                      FadeInImage.assetNetwork(
                                                    placeholder:
                                                        "images/ukp.png",
                                                    image: snapshot.data![index]
                                                        .photoFilepath,
                                                    fit: BoxFit.cover,
                                                    width: 100,
                                                    height: 100,
                                                  ),
                                                )
                                              : Flexible(
                                                  flex: 1,
                                                  child: Image.network(
                                                    "images/ukp.png",
                                                    fit: BoxFit.cover,
                                                  ),
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
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Text(
                          "No results found for\n\"$nrp$name\"\n\nPlease make sure the student you are looking for has a Curriculum Vitae at RE-ACH.",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color.fromARGB(255, 230, 37, 12),
                          ),
                          textAlign: center,
                        ),
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
        ),
      ),
    );
  }
}
