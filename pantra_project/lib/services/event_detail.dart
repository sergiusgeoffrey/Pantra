import 'package:pantra_project/models/event.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;

import '../models/string_obj.dart';

class EventDetailService {
  Future<Event> getAllData({
    int id = 0,
  }) async {
    DateTime nowJakarta = DateTime.now().toUtc().add(const Duration(hours: 7));

    String day = DateFormat('dd').format(nowJakarta);
    String month = DateFormat('MM').format(nowJakarta);
    int year = nowJakarta.year;

    String token = "RwG${month}ne${year}Kc${day}C9w";

    String idStr = "";

    if (id != 0) idStr = "&id=$id";

    final response = await http.get(
        Uri.parse(
            "https://bem-internal.petra.ac.id/reach/api/event/detail/index.php?$idStr"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });

    if (response.statusCode == 200) {
      final Map jsonData = json.decode(response.body);

      Event events;
      events = Event(
        id: jsonData['data']['id'],
        name: jsonData['data']['name'],
        type: jsonData['data']['type'],
        status: jsonData['data']['status'],
        organizer: jsonData['data']['organizer'],
        url: jsonData['data']['url'],
        year: jsonData['data']['year'],
        posterFilepath: jsonData['data']['poster_filepath'],
        divisions: jsonData['data']['divisions'] != null
            ? (jsonData['data']['divisions'] as List)
                .map((e) => StringObj.fromJson(e))
                .toList()
            : null,
      );
      return events;
    } else {
      print(response.body);
      throw Exception('Failed to load data');
    }
  }
}
