class Student {
  String nrp;
  String nama;
  String fakultas;
  String program;
  int angkatan;
  String photoFilepath;

  Student({
    required this.nrp,
    required this.nama,
    required this.fakultas,
    required this.program,
    required this.angkatan,
    required this.photoFilepath,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      nrp: json['nrp'],
      nama: json['nama'],
      fakultas: json['fakultas'],
      program: json['program'],
      angkatan: json['angkatan'],
      photoFilepath: json['photo_filepath'],
    );
  }
}
