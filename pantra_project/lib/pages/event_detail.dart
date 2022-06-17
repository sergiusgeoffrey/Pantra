import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pantra_project/models/event.dart';
import 'package:pantra_project/services/event_detail.dart';
import 'package:url_launcher/url_launcher.dart';

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
    // TODO: implement initState
    super.initState();
    _futureEventDetail = _eventDetailService.getAllData(
      id: widget.event_id,
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  child: Text(
                    "Event Details",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.04,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromRGBO(60, 108, 180, 1),
                    ),
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
                    double heightposter = 0;
                    if (MediaQuery.of(context).size.height <
                        MediaQuery.of(context).size.width) {
                      heightposter =
                          (MediaQuery.of(context).size.width * 0.75) as double;
                    } else {
                      heightposter =
                          (MediaQuery.of(context).size.height * 0.75) as double;
                    }
                    if (snapshot.hasData) {
                      return Column(children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        SizedBox(
                          //make rounded image
                          height: heightposter,
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
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                child: Column(
                                  children: [
                                    Text(
                                      "Event Name",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      snapshot.data!.name,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromRGBO(60, 108, 180, 1)),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                child: Column(
                                  children: [
                                    Text(
                                      "Event Type",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      snapshot.data!.type,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromRGBO(60, 108, 180, 1)),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                child: Column(
                                  children: [
                                    Text(
                                      "Event Status",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      snapshot.data!.status,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromRGBO(60, 108, 180, 1)),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                child: Column(
                                  children: [
                                    Text(
                                      "Event Date",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      snapshot.data!.organizer,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromRGBO(60, 108, 180, 1)),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                child: Column(
                                  children: [
                                    Text(
                                      "Event Year",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      snapshot.data!.year.toString(),
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromRGBO(60, 108, 180, 1)),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                child: Column(
                                  children: [
                                    Text(
                                      "Event URL",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary:
                                              Color.fromRGBO(60, 108, 180, 1)),
                                      onPressed: () async {
                                        await launchUrl(
                                            Uri.parse(snapshot.data!.url));
                                      },
                                      child: Text(
                                        snapshot.data!.url,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Text(
                                      "Event Divisions",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    //make listview for divisions
                                    ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          snapshot.data!.divisions!.length,
                                      itemBuilder: (context, index) {
                                        return Text(
                                          snapshot.data!.divisions![index].data,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.02,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromRGBO(
                                                  60, 108, 180, 1)),
                                        );
                                      },
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
                    return CircularProgressIndicator();
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
