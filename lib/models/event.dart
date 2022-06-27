import 'package:pantra_project/models/string_obj.dart';

class Event {
  int id;
  String name;
  String type;
  String status;
  String organizer;
  int year;
  String url;
  String posterFilepath;
  List<StringObj>? divisions;

  Event(
      {required this.id,
      required this.name,
      required this.type,
      required this.status,
      required this.organizer,
      required this.year,
      required this.url,
      required this.posterFilepath,
      this.divisions});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'] as int,
      name: json['name'],
      type: json['type'],
      status: json['status'],
      organizer: json['organizer'],
      year: json['year'],
      url: json['url'],
      posterFilepath: json['poster_filepath'],
      divisions: json['divisions'] != null
          ? (json['divisions'] as List)
              .map((e) => StringObj.fromJson(e))
              .toList()
          : null,
    );
  }
}
