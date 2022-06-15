class Event {
  String? name;
  String? type;
  String? status;
  String? organizer;
  int? year;
  String? url;
  String? posterFilepath;

  Event(
      {this.name,
      this.type,
      this.status,
      this.organizer,
      this.year,
      this.url,
      this.posterFilepath});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      name: json['name'],
      type: json['type'],
      status: json['status'],
      organizer: json['organizer'],
      year: json['year'],
      url: json['url'],
      posterFilepath: json['poster_filepath'],
    );
  }
}
