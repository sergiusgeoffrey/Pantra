import 'package:flutter/material.dart';
import 'package:pantra_project/models/event.dart';
import 'package:pantra_project/models/string_obj.dart';
import 'package:pantra_project/services/event_details.dart';
import 'package:pantra_project/utils/alignment.dart';
import 'package:pantra_project/utils/color.dart';
import 'package:pantra_project/utils/font_weight.dart';
import 'package:pantra_project/widget/event_details.dart';
import 'package:pantra_project/widget/event_url.dart';
import 'package:pantra_project/widget/text.dart';

class EventDetails extends StatefulWidget {
  final int eventID;
  const EventDetails({Key? key, required this.eventID}) : super(key: key);

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  final EventDetailService _eventDetailService = EventDetailService();
  late Future<Event> _futureEventDetail;

  @override
  void initState() {
    super.initState();
    _futureEventDetail = _eventDetailService.getAllData(
      id: widget.eventID,
    );
  }

  Future<void> _showDivisionDialog(
      List<StringObj> divisions, double heightposter) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: secondary,
          title: TextWidget(
              str: 'Divisions',
              size: MediaQuery.of(context).size.height * 0.03,
              color: primary,
              weight: bold,
              alignment: center),
          content: SizedBox(
            width: heightposter,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: divisions.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: TextWidget(
                      str: divisions[index].data,
                      size: 14,
                      color: primary,
                      weight: bold,
                      alignment: center),
                );
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: TextWidget(
                  str: 'Close',
                  size: 14,
                  color: primary,
                  weight: bold,
                  alignment: center),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double heightposter = 0;
    if (MediaQuery.of(context).size.height >
        MediaQuery.of(context).size.width) {
      heightposter = (MediaQuery.of(context).size.width * 0.75);
    } else {
      heightposter = (MediaQuery.of(context).size.height * 0.75);
    }
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Flexible(
                  flex: 4,
                  fit: FlexFit.tight,
                  child: TextWidget(
                    str: 'Event Detail',
                    size: MediaQuery.of(context).size.height * 0.04,
                    color: primary,
                    weight: bold,
                    alignment: center,
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: secondary,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: FutureBuilder<Event>(
                  future: _futureEventDetail,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          SizedBox(
                            //make rounded image
                            width: heightposter,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.height * 0.05),
                              child: Image.network(
                                snapshot.data!.posterFilepath,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: primary,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                    MediaQuery.of(context).size.height * 0.05),
                              ),
                              color: const Color.fromRGBO(255, 255, 255, 0.4),
                            ),
                            margin: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.height * 0.05,
                                0,
                                MediaQuery.of(context).size.height * 0.05,
                                0),
                            padding: EdgeInsets.fromLTRB(
                                0,
                                MediaQuery.of(context).size.height * 0.05,
                                0,
                                MediaQuery.of(context).size.height * 0.05),
                            child: Column(
                              children: [
                                EventDetailWidget(
                                    strJudul: "Event Name",
                                    isiSnapshot: snapshot.data!.name),
                                EventDetailWidget(
                                    strJudul: "Event Type",
                                    isiSnapshot: snapshot.data!.type),
                                EventDetailWidget(
                                    strJudul: "Event Status",
                                    isiSnapshot: snapshot.data!.status),
                                EventDetailWidget(
                                    strJudul: "Event Organizer",
                                    isiSnapshot: snapshot.data!.organizer),
                                EventDetailWidget(
                                    strJudul: "Event Year",
                                    isiSnapshot:
                                        snapshot.data!.year.toString()),
                                EventURLWidget(URL: snapshot.data!.url),
                                SizedBox(
                                  child: Column(
                                    children: [
                                      TextWidget(
                                        str: "Event Divisions",
                                        size:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                        color: black,
                                        weight: bold,
                                        alignment: center,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          _showDivisionDialog(
                                              snapshot.data!.divisions!,
                                              heightposter);
                                        },
                                        child: TextWidget(
                                          str: "View Divisions",
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02,
                                          color: black,
                                          weight: bold,
                                          alignment: center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          )
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return Column(
                      children: const [
                        CircularProgressIndicator(),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
