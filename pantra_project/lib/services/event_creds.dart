// import 'package:pantra_project/models/event.dart';
// import 'package:pantra_project/models/student_creds.dart';
// import 'dart:convert';
// import 'package:intl/intl.dart';

// import 'package:http/http.dart' as http;

// import '../models/string_obj.dart';

// class StudentCredsService {
//   Future<List<Event>> getAllData({
//     String id = "",
//   }) async {
//     DateTime nowJakarta = DateTime.now().toUtc().add(const Duration(hours: 7));

//     String day = DateFormat('dd').format(nowJakarta);
//     String month = DateFormat('MM').format(nowJakarta);
//     int year = nowJakarta.year;

//     String token = "RwG${month}ne${year}Kc${day}C9w";

//     if (id != "") id = "&id=$id";

//     final response = await http.get(
//       Uri.parse(
//           "https://bem-internal.petra.ac.id/reach/api/event/detail/index.php?$id"),
//       headers: {
//         'Accept': 'application/json',
//         'Authorization': 'Bearer $token',
//       },
//     );

//     if (response.statusCode == 200) {
//       final Map jsonData = json.decode(response.body);
//       List<Event> eventCreds = [];
//       for (var i = 0; i < jsonData['data'].length; i++) {
//         eventCreds.add(
//           Event(
//             name: jsonData['data'][i]['name'],
//             type: jsonData['data'][i]['type'],
//             status: jsonData['data'][i]['status'],
//             organizer: jsonData['data'][i]['organizer'],
//             url: jsonData['data'][i]['url'],
//             year: jsonData['data'][i]['year'],
//             posterFilepath: jsonData['data'][i]['poster_filepath'],
//             divisions: jsonData['data'][i]['divisions'] != null
//                 ? (jsonData['data'][i]['divisions'] as List)
//                     .map((e) => StringObj.fromJson(e))
//                     .toList()
//                 : null,
//               ),
//         );
//       }
//       return eventCreds;
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }
// }
