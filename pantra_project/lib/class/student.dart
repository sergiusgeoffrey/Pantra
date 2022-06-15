class Student{
  // "nrp": "d11200468",
  //           "nama": "Timothy Jefferson",
  //           "fakultas": "Bisnis dan Ekonomi",
  //           "program": "International Business Management",
  //           "angkatan": 2020,
  //           "photo_filepath": "https://bem-internal.petra.ac.id/reach/uploads/cv_photo/d11200468_Timothy JeffersonBlhziP1lX8.jpg"
  String nrp;
  String nama;
  String fakultas;
  String program;
  int angkatan;
  String photo_filepath;

  Student({
    required this.nrp,
    required this.nama,
    required this.fakultas,
    required this.program,
    required this.angkatan,
    required this.photo_filepath,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      nrp: json['nrp'],
      nama: json['nama'],
      fakultas: json['fakultas'],
      program: json['program'],
      angkatan: json['angkatan'],
      photo_filepath: json['photo_filepath'],
    );
  }
}