class StudentCreds {
  String nrp;
  String name;
  String angkatan;
  String jurusan;
  String pengalaman;
  String? portfolio;
  String dateofBirth;
  String instagram;
  String photoFilepath;
  String lastUpdated;

  StudentCreds({
    required this.nrp,
    required this.name,
    required this.angkatan,
    required this.jurusan,
    required this.pengalaman,
    this.portfolio,
    required this.dateofBirth,
    required this.instagram,
    required this.photoFilepath,
    required this.lastUpdated,
  });
}
