import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pantra_project/class/event.dart';
import 'package:pantra_project/class/student.dart';

class studentPage extends StatefulWidget {
  const studentPage({Key? key}) : super(key: key);

  @override
  State<studentPage> createState() => _studentPageState();
}

List<Student> students = [
  Student(
    nrp: 'c14190033',
    name: 'Calvert Tanudihardjo',
    angkatan: '2019',
    jurusan: 'Teknologi Industri - Informatika',
    pengalaman:
        '<i>Whatever you do, work at it with all your heart, as working for the Lord, not for human masters.</i>',
    portfolio: "https://www.linkedin.com/in/calvert-tanudihardjo",
    date_of_birth: '2000-11-23',
    instagram: 'vertfrag',
    photo_filepath:
        'https://bem-internal.petra.ac.id/reach/uploads/cv_photo/c14190033_Calvert Tanudihardjo6awme0yzLd.jpg',
    last_updated: '01-23-VERT 45:67:89',
  ),
  Student(
    nrp: 'd11200083',
    name: 'Kevin Samuel',
    angkatan: '2020',
    jurusan: 'Bisnis dan Ekonomi - Manajemen Bisnis',
    pengalaman:
        'Saya pernah mengikuti kepanitiaan BOM(MLBB)-Spetrakuler, disana saya mendapatkan pengalaman dan relasi.',
    date_of_birth: '2002-02-07',
    instagram: 'kevinsamuel7',
    photo_filepath:
        'https://bem-internal.petra.ac.id/reach/uploads/cv_photo/d11200083_Kevin SamuelzgWe4qGfKS.png',
    last_updated: '17-07-2021 17:20:42',
  ),
  Student(
    nrp: 'c14200005',
    name: 'Kevin Gunawan',
    angkatan: '2020',
    jurusan: 'Teknologi Industri - Sistem Informasi Bisnis',
    pengalaman: 'tidak ada',
    date_of_birth: '2001-08-11',
    instagram: 'kevinz398',
    photo_filepath:
        'https://bem-internal.petra.ac.id/reach/uploads/cv_photo/c14200005_Kevin GunawanWvehaW2Uqp.png',
    last_updated: '11-06-2021 15:42:20',
  )
];

class _studentPageState extends State<studentPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Text(
            "Explore Events",
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.04,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(60, 108, 180, 1)),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Text(
            "Click on any event to see more details",
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.02,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(60, 108, 180, 1)),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          //make a carousel with 10 images from the web
          Container(
            child: CarouselSlider(
              options: CarouselOptions(
                  height: 500,
                  viewportFraction: 1,
                  autoPlayAnimationDuration: const Duration(milliseconds: 300),
                  // autoPlay: true,
                  enlargeCenterPage: false,
                  enableInfiniteScroll: false,
                  disableCenter: true),
              items: students
                  .map(
                    (item) => Container(
                      //change background to black
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        //color: Color.fromRGBO(253,205,95, 1),
                      ),
                      margin: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.height * 0.05,
                          0,
                          MediaQuery.of(context).size.height * 0.05,
                          0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 250,
                            height: 300,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                item.photo_filepath,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            item.name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            item.angkatan,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            item.jurusan,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            item.pengalaman,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              //make center align
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
        ],
      ),
    );
  }
}
