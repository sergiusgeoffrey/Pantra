import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pantra_project/models/event.dart';
import 'package:pantra_project/models/string_obj.dart';
import 'package:pantra_project/pages/details/event.dart';
import 'package:pantra_project/services/event.dart';
import 'package:pantra_project/services/event_organizer.dart';
import 'package:pantra_project/services/event_status.dart';
import 'package:pantra_project/services/event_type.dart';
import 'package:pantra_project/services/event_year.dart';
import 'package:pantra_project/utils/color.dart';
import 'package:pantra_project/widget/title.dart';
import 'package:pantra_project/widget/text.dart';
import 'package:pantra_project/utils/alignment.dart';
import 'package:pantra_project/utils/font_weight.dart';

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
  final GlobalKey<FormFieldState> _keyYear = GlobalKey<FormFieldState>();

  final EventTypeService _eventTypeService = EventTypeService();
  late Future<List<StringObj>> _futureEventTypes;
  final GlobalKey<FormFieldState> _keyType = GlobalKey<FormFieldState>();

  final EventOrganizerService _eventOrganizerService = EventOrganizerService();
  late Future<List<StringObj>> _futureEventOrganizers;
  final GlobalKey<FormFieldState> _keyOrganizer = GlobalKey<FormFieldState>();

  final EventStatusService _eventStatusService = EventStatusService();
  late Future<List<StringObj>> _futureEventStatuses;
  final GlobalKey<FormFieldState> _keyStatus = GlobalKey<FormFieldState>();

  bool showResetFilterButton = false;

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

    // FILTERS
    _futureEventYears = _eventYearService.getAllData();
    _futureEventTypes = _eventTypeService.getAllData();
    _futureEventOrganizers = _eventOrganizerService.getAllData();
    _futureEventStatuses = _eventStatusService.getAllData();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const TitleWidget(
                str1: "Explore Events",
                str2: "Click on any event to see more details!"),
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
                        //print index of current slide
                        onPageChanged: (index, reason) {
                          // PaintingBinding.instance.imageCache.clear();
                          //clear cache of image to prevent memory leak
                        },
                        height: MediaQuery.of(context).size.height * 0.7,
                        viewportFraction: MediaQuery.of(context).size.width >
                                MediaQuery.of(context).size.height
                            ? 0.3
                            : 0.6,
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 300),
                        autoPlay: true,
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
                                            return EventDetails(
                                              eventID: item.id,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: FadeInImage.assetNetwork(
                                        placeholder: "images/ukp.png",
                                        image: item.posterFilepath,
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
                                    color: primary,
                                    size: 19,
                                    weight: bold,
                                    alignment: center),
                                TextWidget(
                                    str: item.type,
                                    color: black,
                                    size: 17,
                                    weight: bold,
                                    alignment: center),
                                TextWidget(
                                    str: item.organizer,
                                    color: black,
                                    size: 17,
                                    weight: bold,
                                    alignment: center),
                                TextWidget(
                                    str: item.year.toString(),
                                    color: black,
                                    size: 17,
                                    weight: bold,
                                    alignment: center),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextWidget(
                                    str: item.status,
                                    color: item.status == "Finished"
                                        ? Colors.green
                                        : item.status == "On Going"
                                            ? orange
                                            : grey,
                                    size: 17,
                                    weight: regular,
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
                          color: grey,
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
                  color: primary,
                ),
                prefixIcon: Icon(
                  icon,
                  color: primary,
                ),
              ),
              menuMaxHeight: 500,
              icon: const Icon(
                Icons.arrow_drop_down,
                color: primary,
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
