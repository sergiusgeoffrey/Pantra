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

    if (id != 0) idStr = "&id=${id}";

    final response = await http.get(
        Uri.parse(
            "https://bem-internal.petra.ac.id/reach/api/event/detail/index.php?$idStr"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });

    if (response.statusCode == 200) {
      final Map jsonData = json.decode(response.body);
      //print json data name
      print("id: " +
          jsonData['data'][0]['id'].toString() +
          jsonData['data'][0]['id'].runtimeType.toString());
      print("name: " +
          jsonData['data'][0]['name'] +
          jsonData['data'][0]['name'].runtimeType.toString());
      print("type: " +
          jsonData['data'][0]['type'] +
          jsonData['data'][0]['type'].runtimeType.toString());
      print("status: " +
          jsonData['data'][0]['status'] +
          jsonData['data'][0]['status'].runtimeType.toString());
      print("organizer: " +
          jsonData['data'][0]['organizer'] +
          jsonData['data'][0]['organizer'].runtimeType.toString());
      print("url: " +
          jsonData['data'][0]['url'] +
          jsonData['data'][0]['url'].runtimeType.toString());
      print("year: " +
          jsonData['data'][0]['year'].toString() +
          jsonData['data'][0]['year'].runtimeType.toString());
      print("poster_filepath: " +
          jsonData['data'][0]['poster_filepath'] +
          jsonData['data'][0]['poster_filepath'].runtimeType.toString());
      // for (String division in jsonData['data'][0]['divisions']) {
      //   print("division: " + division);
      // }
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
        // divisions: jsonData['data'][0]['divisions'] != null
        //     ? (jsonData['data'][0]['divisions'] as List)
        //         .map((e) => StringObj.fromJson(e))
        //         .toList()
        //     : null,
      );
      print(events.name);
      return events;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
