import 'package:pantra_project/models/string_obj.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class StudentNameService {
  Future<String> getStudentName({
    String nrp = "",
  }) async {
    final response = await http.get(
        Uri.parse("http://john.petra.ac.id/~justin/finger.php?s=$nrp"),
        headers: {
          'Accept': 'application/json',
        });

    if (response.statusCode == 200) {
      final Map jsonData = json.decode(response.body);
      return jsonData["hasil"][0]["nama"];
    } else {
      throw Exception('Failed to load data');
    }
  }
}
