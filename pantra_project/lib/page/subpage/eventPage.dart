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
          FutureBuilder<List<Event>>(
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
                    List<Event> events = snapshot.data!;
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
                                    height: 350,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        item.posterFilepath!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    item.name!,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    item.type!,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    item.status!,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    item.organizer!,
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
          //                       item.posterFilepath,
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
