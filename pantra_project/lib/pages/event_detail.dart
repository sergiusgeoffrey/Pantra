import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pantra_project/models/event.dart';
import 'package:pantra_project/services/event_detail.dart';

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
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
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
                          width: MediaQuery.of(context).size.width * 0.70,
                          height: MediaQuery.of(context).size.height * 0.75,
                          child: Image.network(
                            snapshot.data!.posterFilepath,
                            fit: BoxFit.cover,
                          )),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: Column(
                          children: [
                            Text(
                              "Event Name",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.03,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              snapshot.data!.name,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.02,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: Column(
                          children: [
                            Text(
                              "Event Type",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.03,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              snapshot.data!.type,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.02,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: Column(
                          children: [
                            Text(
                              "Event Status",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.03,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              snapshot.data!.status,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.02,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: Column(
                          children: [
                            Text(
                              "Event Date",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.03,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              snapshot.data!.organizer,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.02,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: Column(
                          children: [
                            Text(
                              "Event Year",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.03,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              snapshot.data!.year.toString(),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.02,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: Column(
                          children: [
                            Text(
                              "Event URL",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.03,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              snapshot.data!.url,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.02,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: Column(
                          children: [
                            Text(
                              "Event Divisions",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.03,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "later",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.02,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]);
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return CircularProgressIndicator();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
