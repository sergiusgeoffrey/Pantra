import 'package:pantra_project/models/student_creds.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;

class StudentCredsService {
  Future<List<StudentCreds>> getAllData({
    String name = "",
    String nrp = "",
  }) async {
    DateTime nowJakarta = DateTime.now().toUtc().add(const Duration(hours: 7));

    String day = DateFormat('dd').format(nowJakarta);
    String month = DateFormat('MM').format(nowJakarta);
    int year = nowJakarta.year;

    String token = "RwG${month}ne${year}Kc${day}C9w";

    if (name != "") name = "&name=$name";
    if (nrp != "") nrp = "&nrp=$nrp";

    final response = await http.get(
      Uri.parse(
          "https://bem-internal.petra.ac.id/reach/api/student/creds/index.php?$name$nrp"),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final Map jsonData = json.decode(response.body);
      List<StudentCreds> studentCreds = [];
      for (var i = 0; i < jsonData['data'].length; i++) {
        studentCreds.add(StudentCreds(
          nrp: jsonData['data'][i]['nrp'],
          name: jsonData['data'][i]['name'],
          angkatan: jsonData['data'][i]['angkatan'],
          jurusan: jsonData['data'][i]['jurusan'],
          pengalaman: jsonData['data'][i]['pengalaman'],
          portfolio: jsonData['data'][i]['portfolio'],
          dateofBirth: jsonData['data'][i]['date_of_birth'],
          instagram: jsonData['data'][i]['instagram'],
          photoFilepath: jsonData['data'][i]['photo_filepath'],
          lastUpdated: jsonData['data'][i]['last_updated'],
        ));
      }
      return studentCreds;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
