import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pantra_project/models/event.dart';
import 'package:pantra_project/pages/event_detail.dart';
import 'package:pantra_project/services/event.dart';
import 'package:pantra_project/widget/text.dart';

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
  Color blue = const Color.fromRGBO(60, 108, 180, 1);
  Color black = const Color.fromRGBO(0 , 0, 0, 1);
  TextAlign left = TextAlign.left;
  TextAlign center = TextAlign.center;
  FontWeight bold = FontWeight.bold;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
          TextWidget(str:"Explore Events",color:blue,size:MediaQuery.of(context).size.height * 0.04,weight:bold,alignment:center),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
          TextWidget(str:"Click on any event to see more details",color:blue,size:MediaQuery.of(context).size.height * 0.02,weight:bold,alignment:center),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05,),

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
                        height: 500,
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
                                TextWidget(str:item.name,color:black,size:20,weight:bold,alignment:center),
                                TextWidget(str:item.type,color:black,size:15,weight:bold,alignment:center),
                                TextWidget(str:item.status,color:black,size:15,weight:bold,alignment:center),
                                TextWidget(str:item.organizer,color:black,size:15,weight:bold,alignment:center),
                                TextWidget(str:item.year.toString(),color:black,size:15,weight:bold,alignment:center),
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
