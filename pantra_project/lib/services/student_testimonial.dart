import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:pantra_project/models/student_testimonial.dart';
import 'package:http/http.dart' as http;

class StudentTestimonialService {
  Future<List<StudentTestimonial>> getAllData({
    String nrp = "",
  }) async {
    DateTime nowJakarta = DateTime.now().toUtc().add(const Duration(hours: 7));

    String day = DateFormat('dd').format(nowJakarta);
    String month = DateFormat('MM').format(nowJakarta);
    int year = nowJakarta.year;

    String token = "RwG${month}ne${year}Kc${day}C9w";

    final response = await http.get(
      Uri.parse(
          "https://bem-internal.petra.ac.id/reach/api/student/testimonial/index.php?nrp=$nrp"),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final Map jsonData = json.decode(response.body);

      List<StudentTestimonial> studentTestimonial = [];

      if (jsonData.containsKey('message') &&
          jsonData["message"] == "No data found") {
        return studentTestimonial;
      }

      for (var i = 0; i < jsonData['data'].length; i++) {
        studentTestimonial.add(StudentTestimonial(
          event: jsonData['data'][i]['acara'],
          testimonial: jsonData['data'][i]['testimoni'],
        ));
      }
      return studentTestimonial;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
