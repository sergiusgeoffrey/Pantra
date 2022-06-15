import 'package:pantra_project/models/event.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;

class EventService {
  Future<List<Event>> getAllData() async {
    DateTime nowJakarta = DateTime.now().toUtc().add(const Duration(hours: 7));

    String day = DateFormat('dd').format(nowJakarta);
    String month = DateFormat('MM').format(nowJakarta);
    int year = nowJakarta.year;

    String token = "RwG${month}ne${year}Kc${day}C9w";
    final response = await http.get(
        Uri.parse("https://bem-internal.petra.ac.id/reach/api/event/index.php"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });

    if (response.statusCode == 200) {
      final Map jsonData = json.decode(response.body);
      List<Event> events = [];
      for (var i = 0; i < jsonData['data'].length; i++) {
        events.add(Event(
            name: jsonData['data'][i]['name'],
            type: jsonData['data'][i]['type'],
            status: jsonData['data'][i]['status'],
            organizer: jsonData['data'][i]['organizer'],
            url: jsonData['data'][i]['url'],
            year: jsonData['data'][i]['year'],
            posterFilepath: jsonData['data'][i]['poster_filepath']));
      }
      return events;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
