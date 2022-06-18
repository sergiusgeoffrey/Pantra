import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;
import 'package:pantra_project/models/student.dart';

class StudentService {
  Future<List<Student>> getAllData({
    int studentBatch = 0,
    String experience = "",
    String faculty = "",
    String major = "",
  }) async {
    DateTime nowJakarta = DateTime.now().toUtc().add(const Duration(hours: 7));
    String day = DateFormat('dd').format(nowJakarta);
    String month = DateFormat('MM').format(nowJakarta);
    int year = nowJakarta.year;

    String token = "RwG${month}ne${year}Kc${day}C9w";

    String batchStr = "";

    if (studentBatch != 0) batchStr = "&batch=$studentBatch";
    if (experience != "") experience = "&division=$experience";
    if (faculty != "") faculty = "&faculty=$faculty";
    if (major != "") {
      major.contains("&")
          ? major = major.replaceAll("&", "%26")
          : major = major;
      major = "&major=$major";
    }

    final response = await http.get(
        Uri.parse(
            "https://bem-internal.petra.ac.id/reach/api/student/index.php?$batchStr$experience$faculty$major"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });

    if (response.statusCode == 200) {
      final Map jsonData = json.decode(response.body);
      print(jsonData);

      List<Student> students = [];

      if (jsonData.containsKey('message') &&
          jsonData["message"] == "No data found") {
        return students;
      }

      for (var i = 0; i < jsonData['data'].length; i++) {
        students.add(
          Student(
            nrp: jsonData['data'][i]['nrp'],
            nama: jsonData['data'][i]['nama'],
            fakultas: jsonData['data'][i]['fakultas'],
            program: jsonData['data'][i]['program'],
            angkatan: jsonData['data'][i]['angkatan'],
            photoFilepath: jsonData['data'][i]['photo_filepath'],
          ),
        );
      }
      return students;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
