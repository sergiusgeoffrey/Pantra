import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pantra_project/models/event.dart';
import 'package:pantra_project/models/string_obj.dart';
import 'package:pantra_project/pages/event_detail.dart';
import 'package:pantra_project/services/event.dart';
import 'package:pantra_project/services/event_organizer.dart';
import 'package:pantra_project/services/event_status.dart';
import 'package:pantra_project/services/event_type.dart';
import 'package:pantra_project/services/event_year.dart';

import 'package:pantra_project/utils/colors.dart';
import 'package:pantra_project/widget/text.dart';

class EventPage extends StatefulWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  final EventService _eventService = EventService();
  late Future<List<Event>> _futureEvents;

  final EventYearService _eventYearService = EventYearService();
  late Future<List<StringObj>> _futureEventYears;

  final EventTypeService _eventTypeService = EventTypeService();
  late Future<List<StringObj>> _futureEventTypes;

  final EventOrganizerService _eventOrganizerService = EventOrganizerService();
  late Future<List<StringObj>> _futureEventOrganizers;

  final EventStatusService _eventStatusService = EventStatusService();
  late Future<List<StringObj>> _futureEventStatuses;

  // TODO: add filters to update these values
  int year = 0;
  String type = "";
  String organizer = "";
  String status = "";

  final GlobalKey<FormFieldState> _keyYear = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _keyType = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _keyStatus = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _keyOrganizer = GlobalKey<FormFieldState>();

  bool showResetFilterButton = false;

  @override
  void initState() {
    super.initState();

    _futureEvents = _eventService.getAllData(
      eventYear: year,
      type: type,
      organizer: organizer,
      status: status,
    );

    // FILTERS
    _futureEventYears = _eventYearService.getAllData();
    _futureEventTypes = _eventTypeService.getAllData();
    _futureEventOrganizers = _eventOrganizerService.getAllData();
    _futureEventStatuses = _eventStatusService.getAllData();
  }

  Color blue = const Color.fromRGBO(60, 108, 180, 1);
  Color black = const Color.fromRGBO(0, 0, 0, 1);
  TextAlign left = TextAlign.left;
  TextAlign center = TextAlign.center;
  FontWeight bold = FontWeight.bold;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          TextWidget(
              str: "Explore Events",
              color: blue,
              size: MediaQuery.of(context).size.height * 0.04,
              weight: bold,
              alignment: center),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          TextWidget(
              str: "Click on any event to see more details",
              color: blue,
              size: MediaQuery.of(context).size.height * 0.02,
              weight: bold,
              alignment: center),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          filterEvent(
            "year",
            _futureEventYears,
            Icons.calendar_month,
            _keyYear,
          ),
          filterEvent(
            "type",
            _futureEventTypes,
            Icons.type_specimen,
            _keyType,
          ),
          filterEvent(
            "organizer",
            _futureEventOrganizers,
            Icons.people,
            _keyOrganizer,
          ),
          filterEvent(
            "status",
            _futureEventStatuses,
            Icons.checklist_rtl,
            _keyStatus,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          showResetFilterButton
              ? Container(
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.05),
                  child: SizedBox(
                    width: 150,
                    height: 50,
                    child: showResetFilterButton
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: secondary,
                            ),
                            child: const Text(
                              "Reset Filters",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              setState(
                                () {
                                  year = 0;
                                  type = "";
                                  organizer = "";
                                  status = "";

                                  _futureEvents = _eventService.getAllData(
                                    eventYear: year,
                                    type: type,
                                    organizer: organizer,
                                    status: status,
                                  );

                                  _keyYear.currentState?.reset();
                                  _keyType.currentState?.reset();
                                  _keyStatus.currentState?.reset();
                                  _keyOrganizer.currentState?.reset();

                                  showResetFilterButton = false;
                                },
                              );
                            },
                          )
                        : const SizedBox(
                            width: 0,
                            height: 0,
                          ),
                  ),
                )
              : const SizedBox(
                  width: 0,
                  height: 0,
                ),
          FutureBuilder<List<Event>>(
            future: _futureEvents,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                List<Event> events = snapshot.data!;
                return CarouselSlider(
                  options: CarouselOptions(
                      height: MediaQuery.of(context).size.height * 0.6,
                      viewportFraction: MediaQuery.of(context).size.width >
                              MediaQuery.of(context).size.height
                          ? 0.3
                          : 0.6,
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 300),
                      autoPlay: false,
                      enlargeCenterPage: true,
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 250,
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
                              TextWidget(
                                  str: item.name,
                                  color: black,
                                  size: 20,
                                  weight: bold,
                                  alignment: center),
                              TextWidget(
                                  str: item.type,
                                  color: black,
                                  size: 15,
                                  weight: bold,
                                  alignment: center),
                              TextWidget(
                                  str: item.status,
                                  color: black,
                                  size: 15,
                                  weight: bold,
                                  alignment: center),
                              TextWidget(
                                  str: item.organizer,
                                  color: black,
                                  size: 15,
                                  weight: bold,
                                  alignment: center),
                              TextWidget(
                                  str: item.year.toString(),
                                  color: black,
                                  size: 15,
                                  weight: bold,
                                  alignment: center),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                );
              } else {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: const Center(
                    child: Text(
                      "No events found!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color.fromARGB(255, 230, 37, 12),
                      ),
                    ),
                  ),
                );
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

  Widget filterEvent(element, futureStringObj, icon, key) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05),
      child: FutureBuilder<List<StringObj>>(
        future: futureStringObj,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return DropdownButtonFormField<StringObj>(
              key: key,
              decoration: InputDecoration(
                labelText: "Filter event by $element",
                labelStyle: const TextStyle(
                  color: Color.fromRGBO(60, 108, 180, 1),
                ),
                prefixIcon: Icon(
                  icon,
                  color: primary,
                ),
              ),
              value: null,
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Color.fromRGBO(60, 108, 180, 1),
              ),
              onChanged: (value) {
                setState(() {
                  if (element == "type") type = value!.data;
                  if (element == "organizer") organizer = value!.data;
                  if (element == "status") status = value!.data;
                  if (element == "year") year = int.parse(value!.data);

                  _futureEvents = _eventService.getAllData(
                    eventYear: year,
                    type: type,
                    organizer: organizer,
                    status: status,
                  );

                  showResetFilterButton = true;
                });
              },
              items: snapshot.data?.map<DropdownMenuItem<StringObj>>(
                (StringObj value) {
                  return DropdownMenuItem<StringObj>(
                    value: value,
                    child: Text(value.data),
                  );
                },
              ).toList(),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
