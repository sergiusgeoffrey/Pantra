import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:pantra_project/class/event.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;

// ignore: camel_case_types
class eventService {
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

    print(response.statusCode);

    if (response.statusCode == 200) {
      final json = "[${response.body}]";
      final data = jsonDecode(json);
      List<Event> list = [];
      for (Map<String, dynamic> obj in data) {
        Event event = Event.fromJson(obj);
        list.add(event);
      }
      return list;
    } else {
      throw Exception("Failed to load data");
    }
  }
}
