import 'package:pantra_project/models/string_obj.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;

class EventStatusService {
  Future<List<StringObj>> getAllData() async {
    DateTime nowJakarta = DateTime.now().toUtc().add(const Duration(hours: 7));

    String day = DateFormat('dd').format(nowJakarta);
    String month = DateFormat('MM').format(nowJakarta);
    int year = nowJakarta.year;

    String token = "RwG${month}ne${year}Kc${day}C9w";
    final response = await http.get(
        Uri.parse(
            "https://bem-internal.petra.ac.id/reach/api/event/status/index.php"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });

    if (response.statusCode == 200) {
      final Map jsonData = json.decode(response.body);
      List<StringObj> eventStatus = [];
      for (var i = 0; i < jsonData['data'].length; i++) {
        eventStatus.add(StringObj(
          data: jsonData['data'][i]['status'],
        ));
      }
      return eventStatus;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
