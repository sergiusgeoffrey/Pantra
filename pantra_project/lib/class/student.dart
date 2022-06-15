class Student {
  // "id": 1,
  // "nrp": "c14190033",
  // "name": "Calvert Tanudihardjo",
  // "angkatan": 2019,
  // "jurusan": "Teknologi Industri - Informatika",
  // "pengalaman": "<i>Whatever you do, work at it with all your heart, as working for the Lord, not for human masters.</i>",
  // "portfolio": "https://www.linkedin.com/in/calvert-tanudihardjo",
  // "date_of_birth": "2000-11-23",
  // "instagram": "vertfrag",
  // "photo_filepath": "https://bem-internal.petra.ac.id/reach/uploads/cv_photo/c14190033_Calvert Tanudihardjo6awme0yzLd.jpg",
  // "last_updated": "01-23-VERT 45:67:89"
  String nrp;
  String name;
  String angkatan;
  String jurusan;
  String pengalaman;
  String? portfolio;
  String date_of_birth;
  String instagram;
  String photo_filepath;
  String last_updated;

  Student({
    required this.nrp,
    required this.name,
    required this.angkatan,
    required this.jurusan,
    required this.pengalaman,
    this.portfolio,
    required this.date_of_birth,
    required this.instagram,
    required this.photo_filepath,
    required this.last_updated,
  });
}
//make 1 student object
Student stud = Student(
  nrp: 'c14190033',
  name: 'Calvert Tanudihardjo',
  angkatan: '2019',
  jurusan: 'Teknologi Industri - Informatika',
  pengalaman: '<i>Whatever you do, work at it with all your heart, as working for the Lord, not for human masters.</i>',
  portfolio: "https://www.linkedin.com/in/calvert-tanudihardjo",
  date_of_birth: '2000-11-23',
  instagram: 'vertfrag',
  photo_filepath: 'https://bem-internal.petra.ac.id/reach/uploads/cv_photo/c14190033_Calvert Tanudihardjo6awme0yzLd.jpg',
  last_updated: '01-23-VERT 45:67:89',
);

//"id": 62,
// "nrp": "d11200083",
// "name": "Kevin Samuel",
// "angkatan": 2020,
// "jurusan": "Bisnis dan Ekonomi - Manajemen Bisnis",
// "pengalaman": "Saya pernah mengikuti kepanitiaan BOM(MLBB)-Spetrakuler, disana saya mendapatkan pengalaman dan relasi.",
// "date_of_birth": "2002-02-07",
// "instagram": "kevinsamuel7",
// "photo_filepath": "https://bem-internal.petra.ac.id/reach/uploads/cv_photo/d11200083_Kevin SamuelzgWe4qGfKS.png",
// "last_updated": "17-07-2021 17:20:42"

//make 1 student object
Student stud2 = Student(
  nrp: 'd11200083',
  name: 'Kevin Samuel',
  angkatan: '2020',
  jurusan:
  'Bisnis dan Ekonomi - Manajemen Bisnis',
  pengalaman: 'Saya pernah mengikuti kepanitiaan BOM(MLBB)-Spetrakuler, disana saya mendapatkan pengalaman dan relasi.',
  date_of_birth: '2002-02-07',
  instagram: 'kevinsamuel7',
  photo_filepath: 'https://bem-internal.petra.ac.id/reach/uploads/cv_photo/d11200083_Kevin SamuelzgWe4qGfKS.png',
  last_updated: '17-07-2021 17:20:42',
);

// "id": 593,
//"nrp": "c14200005",
//"name": "Kevin Gunawan",
//"angkatan": 2020,
//"jurusan": "Teknologi Industri - Sistem Informasi Bisnis",
//"pengalaman": "tidak ada",
//"date_of_birth": "2001-08-11",
//"instagram": "kevinz398",
//"photo_filepath": "https://bem-internal.petra.ac.id/reach/uploads/cv_photo/c14200005_Kevin GunawanWvehaW2Uqp.png",
//"last_updated": "11-06-2021 15:42:20"

//make 1 student object

Student stud3 = Student(
  nrp: 'c14200005',
  name: 'Kevin Gunawan',
  angkatan: '2020',
  jurusan: 'Teknologi Industri - Sistem Informasi Bisnis',
  pengalaman: 'tidak ada',
  date_of_birth: '2001-08-11',
  instagram: 'kevinz398',
  photo_filepath: 'https://bem-internal.petra.ac.id/reach/uploads/cv_photo/c14200005_Kevin GunawanWvehaW2Uqp.png',
  last_updated: '11-06-2021 15:42:20',
);