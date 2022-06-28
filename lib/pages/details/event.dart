import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:pantra_project/models/event.dart';
import 'package:pantra_project/models/string_obj.dart';
import 'package:pantra_project/services/event/event_details.dart';
import 'package:pantra_project/services/firestore.dart';
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
  bool wishlist = false;
  String nrp = "";

  Future<bool> _onLikeButtonTapped(bool istapped) async {
    await Database.updateWishlist(nrp: nrp, eventID: widget.eventID.toString())
        .then((value) {
      setState(() {
        wishlist = !wishlist;
      });
      wishlist
          ? ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text(
                  "Event added to wishlist",
                ),
                duration: const Duration(seconds: 1),
                backgroundColor: Colors.green,
                action: SnackBarAction(
                  label: "DISMISS",
                  textColor: Colors.white,
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  },
                ),
              ),
            )
          : ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text(
                  "Event removed from wishlist",
                ),
                duration: const Duration(seconds: 1),
                backgroundColor: red,
                action: SnackBarAction(
                  label: "DISMISS",
                  textColor: Colors.white,
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  },
                ),
              ),
            );
    });
    return wishlist;
  }

  @override
  void initState() {
    super.initState();

    nrp = FirebaseAuth.instance.currentUser!.email.toString().split('@')[0];

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
          scrollable: true,
          backgroundColor: secondary,
          title: TextWidget(
            str: 'Available Divisions',
            size: MediaQuery.of(context).size.height * 0.025,
            color: primary,
            weight: bold,
            alignment: center,
          ),
          content: SizedBox(
            width: heightposter,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: divisions.length,
              itemBuilder: (BuildContext context, int index) {
                return divisions[index].data == "BPH" ||
                        divisions[index].data == "Badan Pengurus Harian" ||
                        divisions[index].data == "Pusat"
                    ? Container()
                    : TextWidget(
                        str: divisions[index].data,
                        size: 18,
                        color: black,
                        weight: regular,
                        alignment: center,
                      );
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              child: TextWidget(
                str: 'Close',
                size: 14,
                color: white,
                weight: bold,
                alignment: center,
              ),
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
    return Container(
      color: secondary,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: background,
          floatingActionButton: FloatingActionButton(
            backgroundColor: primary,
            onPressed: () {},
            child: LikeButton(
              isLiked: wishlist,
              onTap: _onLikeButtonTapped,
            ),
          ),
          body: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.075,
                width: MediaQuery.of(context).size.width,
                color: secondary,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 1,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        color: primary,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Flexible(
                      flex: 4,
                      fit: FlexFit.tight,
                      child: TextWidget(
                        str: "Event Details",
                        size: MediaQuery.of(context).size.height * 0.03,
                        color: primary,
                        weight: bold,
                        alignment: center,
                      ),
                    ),
                  ],
                ),
              ),
              ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: Expanded(
                  child: SingleChildScrollView(
                    child: FutureBuilder<Event>(
                      future: _futureEventDetail,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                              ),
                              SizedBox(
                                width: heightposter,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    snapshot.data!.posterFilepath,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.height * 0.05,
                                    0,
                                    MediaQuery.of(context).size.height * 0.05,
                                    0),
                                padding: EdgeInsets.fromLTRB(
                                  0,
                                  MediaQuery.of(context).size.height * 0.05,
                                  0,
                                  MediaQuery.of(context).size.height * 0.05,
                                ),
                                child: Column(
                                  children: [
                                    EventDetailWidget(
                                      strJudul: "Name",
                                      isiSnapshot: snapshot.data!.name,
                                    ),
                                    EventDetailWidget(
                                      strJudul: "Type",
                                      isiSnapshot: snapshot.data!.type,
                                    ),
                                    EventDetailWidget(
                                      strJudul: "Organizer",
                                      isiSnapshot: snapshot.data!.organizer,
                                    ),
                                    EventDetailWidget(
                                      strJudul: "Year",
                                      isiSnapshot:
                                          snapshot.data!.year.toString(),
                                    ),
                                    EventDetailWidget(
                                      strJudul: "Status",
                                      isiSnapshot: snapshot.data!.status,
                                    ),
                                    EventURLWidget(url: snapshot.data!.url),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Column(
                                      children: [
                                        TextWidget(
                                          str: "Divisions",
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02,
                                          color: black,
                                          weight: bold,
                                          alignment: center,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: secondary,
                                          ),
                                          onPressed: () {
                                            _showDivisionDialog(
                                                snapshot.data!.divisions!,
                                                heightposter);
                                          },
                                          child: TextWidget(
                                            str: "See Available Divisions",
                                            size: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.025,
                                            color: primary,
                                            weight: bold,
                                            alignment: center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        Database.getSpecificWishlist(
                                nrp: nrp, eventID: widget.eventID.toString())
                            .then((value) => setState(() {
                                  wishlist = value;
                                }));
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
        ),
      ),
    );
  }
}
