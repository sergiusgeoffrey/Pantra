// ignore_for_file: prefer_const_constructors, unnecessary_new, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pantra_project/models/event.dart';
import 'package:pantra_project/models/string_obj.dart';
import 'package:pantra_project/services/event_detail.dart';
import 'package:pantra_project/widget/event_detail_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widget/text.dart';

class eventDetails extends StatefulWidget {
  final int event_id;
  const eventDetails({Key? key, required this.event_id}) : super(key: key);

  @override
  State<eventDetails> createState() => _eventDetailsState();
}

class _eventDetailsState extends State<eventDetails> {
  final EventDetailService _eventDetailService = EventDetailService();
  late Future<Event> _futureEventDetail;

  @override
  void initState() {
    super.initState();
    _futureEventDetail = _eventDetailService.getAllData(
      id: widget.event_id,
    );
  }

  Color blue = const Color.fromRGBO(60, 108, 180, 1);
  Color black = const Color.fromRGBO(0, 0, 0, 1);
  TextAlign left = TextAlign.left;
  TextAlign center = TextAlign.center;
  FontWeight bold = FontWeight.bold;
  Future<void> _showDivisionDialog(
      List<StringObj> divisions, double heightposter) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //change dialog color
          backgroundColor: const Color.fromRGBO(251, 203, 92, 1),
          title: TextWidget(
              str: 'Divisions',
              size: MediaQuery.of(context).size.height * 0.03,
              color: blue,
              weight: bold,
              alignment: center),
          content: Container(
            width: heightposter,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: divisions.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: TextWidget(
                      str: divisions[index].data,
                      size: 14,
                      color: blue,
                      weight: bold,
                      alignment: center),
                );
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: TextWidget(
                str:'Close',
                size:14,
                color:blue,
                weight:bold,
                alignment:center),
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
      heightposter = (MediaQuery.of(context).size.width * 0.75) as double;
    } else {
      heightposter = (MediaQuery.of(context).size.height * 0.75) as double;
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
                    color: blue,
                    weight: bold,
                    alignment: center,
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Color.fromRGBO(251, 203, 92, 1),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: FutureBuilder<Event>(
                  future: _futureEventDetail,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(children: [
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
                              color: Color.fromRGBO(60, 108, 180, 1),
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                  MediaQuery.of(context).size.height * 0.05),
                            ),
                            color: Color.fromRGBO(255, 255, 255, 0.4),
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
                              EventDetailWidget(strJudul: "Event Name", isiSnapshot: snapshot.data!.name),
                              EventDetailWidget(strJudul: "Event Type", isiSnapshot: snapshot.data!.type),
                              EventDetailWidget(strJudul: "Event Status", isiSnapshot: snapshot.data!.status),
                              EventDetailWidget(strJudul: "Event Organizer", isiSnapshot: snapshot.data!.organizer),
                              EventDetailWidget(strJudul: "Event Year", isiSnapshot: snapshot.data!.year.toString()),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                child: Column(
                                  children: [
                                    TextWidget(
                                      str: "Event URL",
                                      size: MediaQuery.of(context).size.height *
                                          0.03,
                                      color: black,
                                      weight: bold,
                                      alignment: center,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: Color.fromRGBO(
                                                60, 108, 180, 1)),
                                        onPressed: () async {
                                          await launchUrl(
                                              Uri.parse(snapshot.data!.url));
                                        },
                                        child: 
                                        TextWidget(
                                      str: snapshot.data!.url,
                                      size: MediaQuery.of(context).size.height *
                                          0.02,
                                      color: black,
                                      weight: bold,
                                      alignment: center,
                                    ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                child: Column(
                                  children: [
                                    TextWidget(
                                      str: "Event Divisions",
                                      size: MediaQuery.of(context).size.height *
                                          0.03,
                                      color: black,
                                      weight: bold,
                                      alignment: center,
                                    ),
                                    //make listview for divisions
                                    ElevatedButton(
                                      onPressed: () {
                                        _showDivisionDialog(
                                            snapshot.data!.divisions!,
                                            heightposter);
                                      },
                                      child: 
                                      TextWidget(
                                        str: "View Divisions",
                                        size: MediaQuery.of(context).size.height *
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
                      ]);
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return Column(
                      children: [
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
