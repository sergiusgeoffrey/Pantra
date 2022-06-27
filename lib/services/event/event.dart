import 'package:pantra_project/models/event.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:pantra_project/models/string_obj.dart';

import 'package:http/http.dart' as http;

class EventService {
  Future<List<Event>> getAllData({
    int eventYear = 0,
    String type = "",
    String organizer = "",
    String status = "",
    String id = "",
  }) async {
    DateTime nowJakarta = DateTime.now().toUtc().add(const Duration(hours: 7));

    String day = DateFormat('dd').format(nowJakarta);
    String month = DateFormat('MM').format(nowJakarta);
    int year = nowJakarta.year;

    String token = "RwG${month}ne${year}Kc${day}C9w";

    String yearStr = "";
    String idStr = "";

    if (eventYear != 0) yearStr = "&year=$eventYear";
    if (type != "") {
      type.contains("&") ? type = type.replaceAll("&", "%26") : type = type;
      type = "&type=$type";
    }
    if (organizer != "") organizer = "&organizer=$organizer";
    if (status != "") status = "&status=$status";
    if (id != "") idStr = "&id=$id";

    final response = await http.get(
        Uri.parse(
            "https://bem-internal.petra.ac.id/reach/api/event/index.php?$yearStr$type$organizer$status$idStr"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });

    if (response.statusCode == 200) {
      final Map jsonData = json.decode(response.body);

      List<Event> events = [];

      if (jsonData.containsKey('message') &&
          jsonData["message"] == "No data found") {
        return events;
      }

      for (var i = 0; i < jsonData['data'].length; i++) {
        events.add(Event(
          id: jsonData['data'][i]['id'],
          name: jsonData['data'][i]['name'],
          type: jsonData['data'][i]['type'],
          status: jsonData['data'][i]['status'],
          organizer: jsonData['data'][i]['organizer'],
          url: jsonData['data'][i]['url'],
          year: jsonData['data'][i]['year'],
          posterFilepath: jsonData['data'][i]['poster_filepath'],
          divisions: jsonData['data'][i]['divisions'] != null
              ? (jsonData['data'][i]['divisions'] as List)
                  .map((e) => StringObj.fromJson(e))
                  .toList()
              : null,
        ));
      }
      return events;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
