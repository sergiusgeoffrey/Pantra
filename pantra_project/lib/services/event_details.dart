import 'package:pantra_project/models/event.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:pantra_project/models/string_obj.dart';

import 'package:http/http.dart' as http;

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

      List<StringObj> divisions = [];
      if (jsonData['data'][0]['divisions'].length > 0) {
        for (var i = 0; i < jsonData['data'][0]['divisions'].length; i++) {
          divisions.add(StringObj(
            data: jsonData['data'][0]['divisions'][i]['division'],
          ));
        }
      }

      Event events;
      events = Event(
        id: jsonData['data'][0]['id'],
        name: jsonData['data'][0]['name'],
        type: jsonData['data'][0]['type'],
        status: jsonData['data'][0]['status'],
        organizer: jsonData['data'][0]['organizer'],
        url: jsonData['data'][0]['url'],
        year: jsonData['data'][0]['year'],
        posterFilepath: jsonData['data'][0]['poster_filepath'],
        divisions: divisions,
      );
      return events;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
