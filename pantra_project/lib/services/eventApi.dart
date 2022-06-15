import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:pantra_project/class/event.dart';
import 'dart:convert';
import 'package:intl/intl.dart';


import 'package:http/http.dart' as http;

class eventService {
  Future<List<Event>> getAllData() async {
    //set timezone to jakarta
    DateTime nowJakarta = DateTime.now().toUtc().add(Duration(hours: 7));
    //get today day and month and year

    String day = DateFormat('dd').format(nowJakarta);
    String month = DateFormat('MM').format(nowJakarta);
    int year = nowJakarta.year;
    log("day: $day, month: $month, year: $year");

    String token = "RwG${month}ne${year}Kc${day}C9w";
    final response = await http.get(
        Uri.parse("https://bem-internal.petra.ac.id/reach/api/event/index.php"),
        headers: {
          'Accept': 'application/json',
          'Authorization-Bearer': 'Bearer $token',
        });
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      // List<Event> events =
      //     jsonResponse.map((event) => new Event.fromJson(event)).toList();
      // return events;

      return jsonResponse.map((e) => Event.fromJson(e)).toList();
    }
    else {
      throw Exception("Failed to load data");
    }
  }
}
