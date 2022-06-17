import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pantra_project/models/event.dart';
import 'package:pantra_project/pages/event_detail.dart';
import 'package:pantra_project/services/event.dart';

class EventPage extends StatefulWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  final EventService _eventService = EventService();
  late Future<List<Event>> _futureEvents;

  // TODO: add filters to update these values
  int year = 0;
  String type = "";
  String organizer = "";
  String status = "";

  @override
  void initState() {
    super.initState();
    _futureEvents = _eventService.getAllData(
      eventYear: year,
      type: type,
      organizer: organizer,
      status: status,
    );
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
                color: const Color.fromRGBO(60, 108, 180, 1)),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Text(
            "Click on any event to see more details",
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.02,
                fontWeight: FontWeight.bold,
                color: const Color.fromRGBO(60, 108, 180, 1)),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          FutureBuilder<List<Event>>(
            future: _futureEvents,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else {
                  List<Event> events = snapshot.data!;
                  return CarouselSlider(
                    options: CarouselOptions(
                        height: MediaQuery.of(context).size.height * 0.8,
                        viewportFraction: 1,
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 300),
                        autoPlay: true,
                        enlargeCenterPage: false,
                        enableInfiniteScroll: false,
                        disableCenter: true),
                    items: events
                        .map(
                          (item) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.height * 0.05,
                                0,
                                MediaQuery.of(context).size.height * 0.05,
                                0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 250,
                                  height: 350,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return eventDetails(
                                              event_id: item.id,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        item.posterFilepath,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  item.name,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  item.type,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  item.status,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  item.organizer,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  item.year.toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
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
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
        ],
      ),
    );
  }
}
