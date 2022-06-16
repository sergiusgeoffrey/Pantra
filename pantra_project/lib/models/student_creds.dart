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

  factory StudentCreds.fromJson(Map<String, dynamic> json) {
    return StudentCreds(
      nrp: json['nrp'],
      name: json['name'],
      angkatan: json['angkatan'],
      jurusan: json['jurusan'],
      pengalaman: json['pengalaman'],
      portfolio: json['portfolio'],
      dateofBirth: json['date_of_birth'],
      instagram: json['instagram'],
      photoFilepath: json['photo_filepath'],
      lastUpdated: json['last_updated'],
    );
}
}
