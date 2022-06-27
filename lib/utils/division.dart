import 'package:pantra_project/models/string_obj.dart';

List<Map<String, String>> division = [
  {
    "division": "Acara",
  },
  {
    "division": "PDD",
  },
  {
    "division": "Sekretariat",
  },
  {
    "division": "Public Relation",
  },
  {
    "division": "Perlengkapan",
  },
  {
    "division": "Konsumsi",
  },
  {
    "division": "IT",
  },
  {
    "division": "Sponsor",
  },
  {
    "division": "Keamanan",
  },
  {
    "division": "Kesehatan",
  },
  {
    "division": "Materi",
  },
  {
    "division": "Peran",
  },
  {
    "division": "Asisten Tutor",
  },
];

Future<List<StringObj>> getDivision() async {
  List<StringObj> divisionList = [];
  for (var i = 0; i < division.length; i++) {
    divisionList.add(StringObj(
      data: division[i]['division'] ?? '',
    ));
  }
  return divisionList;
}
