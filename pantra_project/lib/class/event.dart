class Event {
  String name;
  String type;
  String status;
  String organizer;
  int year;
  String url;
  String poster_filepath;

  Event(
      {required this.name,
      required this.type,
      required this.status,
      required this.organizer,
      required this.year,
      required this.url,
      required this.poster_filepath});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      name: json['name'],
      type: json['type'],
      status: json['status'],
      organizer: json['organizer'],
      year: json['year'],
      url: json['url'],
      poster_filepath: json['poster_filepath'],
    );
  }
}