// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:pantra_project/class/event.dart';
import 'package:pantra_project/class/student.dart';
import 'package:pantra_project/page/subpage/eventPage.dart';
import 'package:pantra_project/page/subpage/studentPage.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

//make simple class for user that has only username and password

//create 5 events
List<Event> events = [
  Event(
      name: 'United for Others 2021',
      type: 'Community Service',
      status: 'Finished',
      organizer: 'BEM UK Petra',
      url: 'http://unitedforothers.org/index.html',
      year: 2021,
      poster_filepath:
          'https://bem-internal.petra.ac.id/reach/uploads/poster/United%20for%20Others%202021_trgJjOibeE.jpg'),
  Event(
      name: 'Linked Through LinkedIn 2021',
      type: 'Webinar',
      status: 'Finished',
      organizer: 'BEM UK Petra',
      url: 'https://www.instagram.com/lifeatbempetra/',
      year: 2021,
      poster_filepath:
          'https://marketplace.canva.com/EAE5t9abmqM/1/0/1131w/canva-poster-restoran-ramah-lingkungan-bebas-sedotan-plastik-ilustrasi-polos-lucu-hijau-zamrud-B9l9LTbzQUI.jpg'),
  Event(
      name: 'Sosialisasi Pilkada 2020',
      type: 'Webinar',
      status: 'Finished',
      organizer: 'BEM UK Petra',
      url: 'https://www.instagram.com/bempetra/',
      year: 2021,
      poster_filepath:
          'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/covid-19-corona-virus-prevention-poster-design-template-7eafeb97181606ad03bbe2e56324593c_screen.jpg?ts=1637005703'),
  Event(
      name: 'LKMM-TM XXX',
      type: 'Webinar',
      status: 'Finished',
      organizer: 'BEM UK Petra',
      url: 'http://lkmm-tm.petra.ac.id/XXX/',
      year: 2021,
      poster_filepath:
          'https://marketplace.canva.com/EAE5t9abmqM/1/0/1131w/canva-poster-restoran-ramah-lingkungan-bebas-sedotan-plastik-ilustrasi-polos-lucu-hijau-zamrud-B9l9LTbzQUI.jpg'),
  Event(
      name: 'Ini Talkshow Edukasi Movie 2021',
      type: 'Webinar',
      status: 'Finished',
      organizer: 'BEM UK Petra',
      url: 'https://www.instagram.com/item.2021/',
      year: 2021,
      poster_filepath:
          'https://marketplace.canva.com/EAE5t9abmqM/1/0/1131w/canva-poster-restoran-ramah-lingkungan-bebas-sedotan-plastik-ilustrasi-polos-lucu-hijau-zamrud-B9l9LTbzQUI.jpg'),
];

class _HomeState extends State<Home> {
  List<Widget> pageList = <Widget>[eventPage(), studentPage()];
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Color.fromRGBO(255, 255, 255, 1),
          color: Color.fromRGBO(251, 203, 92, 1),
          onTap: (value) {
            setState(() {
              pageIndex = value;
            });
          },
          items: [
            Icon(
              Icons.home,
              color: Color.fromRGBO(60, 108, 180, 1),
            ),
            Icon(
              Icons.search,
              color: Color.fromRGBO(60, 108, 180, 1),
            ),
            Icon(
              Icons.person,
              color: Color.fromRGBO(60, 108, 180, 1),
            ),
            Icon(
              Icons.delete,
              color: Color.fromRGBO(60, 108, 180, 1),
            ),
          ]),
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      body: pageList[pageIndex],
      // body: SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       SizedBox(
      //         height: MediaQuery.of(context).size.height * 0.05,
      //       ),
      //       Text(
      //         "Explore Events",
      //         style: TextStyle(
      //             fontSize: MediaQuery.of(context).size.height * 0.04,
      //             fontWeight: FontWeight.bold,
      //             color: Color.fromRGBO(60, 108, 180, 1)),
      //       ),
      //       SizedBox(
      //         height: MediaQuery.of(context).size.height * 0.01,
      //       ),
      //       Text(
      //         "Click on any event to see more details",
      //         style: TextStyle(
      //             fontSize: MediaQuery.of(context).size.height * 0.02,
      //             fontWeight: FontWeight.bold,
      //             color: Color.fromRGBO(60, 108, 180, 1)),
      //       ),
      //       SizedBox(
      //         height: MediaQuery.of(context).size.height * 0.05,
      //       ),
      //       //make a carousel with 10 images from the web
      //       Container(
      //         child: CarouselSlider(
      //           options: CarouselOptions(
      //               height: 500,
      //               viewportFraction: 1,
      //               autoPlayAnimationDuration:
      //                   const Duration(milliseconds: 300),
      //               // autoPlay: true,
      //               enlargeCenterPage: false,
      //               enableInfiniteScroll: false,
      //               disableCenter: true),
      //           items: events
      //               .map(
      //                 (item) => Container(
      //                   //change background to black
      //                   decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.circular(10),
      //                     //color: Color.fromRGBO(253,205,95, 1),
      //                   ),
      //                   margin: EdgeInsets.fromLTRB(
      //                       MediaQuery.of(context).size.height * 0.05,
      //                       0,
      //                       MediaQuery.of(context).size.height * 0.05,
      //                       0),
      //                   child: Column(
      //                     mainAxisAlignment: MainAxisAlignment.center,
      //                     children: [
      //                       Container(
      //                         width: 250,
      //                         height: 300,
      //                         child: ClipRRect(
      //                           borderRadius: BorderRadius.circular(10),
      //                           child: Image.network(
      //                             item.poster_filepath,
      //                             fit: BoxFit.cover,
      //                           ),
      //                         ),
      //                       ),
      //                       SizedBox(
      //                         height: 10,
      //                       ),
      //                       Text(
      //                         item.name,
      //                         style: TextStyle(
      //                           fontSize: 20,
      //                           fontWeight: FontWeight.bold,
      //                         ),
      //                       ),
      //                       Text(
      //                         item.type,
      //                         style: TextStyle(
      //                           fontSize: 15,
      //                           fontWeight: FontWeight.bold,
      //                         ),
      //                       ),
      //                       Text(
      //                         item.status,
      //                         style: TextStyle(
      //                           fontSize: 15,
      //                           fontWeight: FontWeight.bold,
      //                         ),
      //                       ),
      //                       Text(
      //                         item.organizer,
      //                         style: TextStyle(
      //                           fontSize: 15,
      //                           fontWeight: FontWeight.bold,
      //                         ),
      //                       ),
      //                       Text(
      //                         item.year.toString(),
      //                         style: TextStyle(
      //                           fontSize: 15,
      //                           fontWeight: FontWeight.bold,
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               )
      //               .toList(),
      //         ),
      //       ),
      //       SizedBox(
      //         height: MediaQuery.of(context).size.height * 0.05,
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
