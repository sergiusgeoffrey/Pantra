// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pantra_project/class/event.dart';
import 'package:pantra_project/services/eventApi.dart';

class eventPage extends StatefulWidget {
  const eventPage({Key? key}) : super(key: key);

  @override
  State<eventPage> createState() => _eventPageState();
}

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

class _eventPageState extends State<eventPage> {
  eventService _eventService = eventService();
  late Future<List<Event>> _futureEvents;

  @override
  void initState() {
    super.initState();
    _futureEvents = _eventService.getAllData();
  }

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
          FutureBuilder(
              future: _futureEvents,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.hasError) {
                    return new Text(snapshot.error.toString());
                  } else {
                    return CarouselSlider(
                      options: CarouselOptions(
                          height: 500,
                          viewportFraction: 1,
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 300),
                          // autoPlay: true,
                          enlargeCenterPage: false,
                          enableInfiniteScroll: false,
                          disableCenter: true),
                      items: events
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
                                        item.poster_filepath,
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
                                    item.type,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    item.status,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    item.organizer,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    item.year.toString(),
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    );
                  }
                }
              }),
          //make a carousel with 10 images from the web
          // Container(
          //   child: CarouselSlider(
          //     options: CarouselOptions(
          //         height: 500,
          //         viewportFraction: 1,
          //         autoPlayAnimationDuration: const Duration(milliseconds: 300),
          //         // autoPlay: true,
          //         enlargeCenterPage: false,
          //         enableInfiniteScroll: false,
          //         disableCenter: true),
          //     items: events
          //         .map(
          //           (item) => Container(
          //             //change background to black
          //             decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(10),
          //               //color: Color.fromRGBO(253,205,95, 1),
          //             ),
          //             margin: EdgeInsets.fromLTRB(
          //                 MediaQuery.of(context).size.height * 0.05,
          //                 0,
          //                 MediaQuery.of(context).size.height * 0.05,
          //                 0),
          //             child: Column(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 Container(
          //                   width: 250,
          //                   height: 300,
          //                   child: ClipRRect(
          //                     borderRadius: BorderRadius.circular(10),
          //                     child: Image.network(
          //                       item.poster_filepath,
          //                       fit: BoxFit.cover,
          //                     ),
          //                   ),
          //                 ),
          //                 SizedBox(
          //                   height: 10,
          //                 ),
          //                 Text(
          //                   item.name,
          //                   style: TextStyle(
          //                     fontSize: 20,
          //                     fontWeight: FontWeight.bold,
          //                   ),
          //                 ),
          //                 Text(
          //                   item.type,
          //                   style: TextStyle(
          //                     fontSize: 15,
          //                     fontWeight: FontWeight.bold,
          //                   ),
          //                 ),
          //                 Text(
          //                   item.status,
          //                   style: TextStyle(
          //                     fontSize: 15,
          //                     fontWeight: FontWeight.bold,
          //                   ),
          //                 ),
          //                 Text(
          //                   item.organizer,
          //                   style: TextStyle(
          //                     fontSize: 15,
          //                     fontWeight: FontWeight.bold,
          //                   ),
          //                 ),
          //                 Text(
          //                   item.year.toString(),
          //                   style: TextStyle(
          //                     fontSize: 15,
          //                     fontWeight: FontWeight.bold,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         )
          //         .toList(),
          //   ),
          // ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
        ],
      ),
    );
  }
}
