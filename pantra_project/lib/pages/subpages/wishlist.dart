import 'package:flutter/material.dart';
import 'package:pantra_project/models/event.dart';
import 'package:pantra_project/pages/details/event.dart';
import 'package:pantra_project/services/firestore.dart';
import 'package:pantra_project/utils/alignment.dart';
import 'package:pantra_project/utils/color.dart';
import 'package:pantra_project/utils/font_weight.dart';
import 'package:pantra_project/widget/text.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({Key? key, required this.nrp}) : super(key: key);
  final String nrp;

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Row(
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
                    str: 'Your Event Wishlist',
                    size: MediaQuery.of(context).size.height * 0.03,
                    color: primary,
                    weight: bold,
                    alignment: center,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            FutureBuilder<List<Event>>(
              future: Database.getWishlist(nrp: widget.nrp),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return EventDetails(
                                          eventID: snapshot.data![0].id);
                                    },
                                  ),
                                );
                              },
                              child: Card(
                                color: light_secondary,
                                elevation: 5,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        flex: 1,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextWidget(
                                                str: snapshot.data![index].name,
                                                color: primary,
                                                size: 20,
                                                weight: bold,
                                                alignment: left),
                                            TextWidget(
                                                str: snapshot
                                                    .data![index].organizer
                                                    .toUpperCase(),
                                                color: black,
                                                size: 18,
                                                weight: bold,
                                                alignment: left),
                                            TextWidget(
                                                str: snapshot.data![index].type,
                                                color: black,
                                                size: 18,
                                                weight: regular,
                                                alignment: left),
                                            TextWidget(
                                                str: snapshot.data![index].year
                                                    .toString(),
                                                color: black,
                                                size: 18,
                                                weight: regular,
                                                alignment: left),
                                          ],
                                        ),
                                      ),
                                      snapshot.data![index].posterFilepath !=
                                              null
                                          ? Flexible(
                                              flex: 1,
                                              child: FadeInImage.assetNetwork(
                                                placeholder: "images/ukp.png",
                                                image: snapshot.data![index]
                                                    .posterFilepath,
                                                fit: BoxFit.cover,
                                                width: 100,
                                                height: 100,
                                              ),
                                            )
                                          : Flexible(
                                              flex: 1,
                                              child: Image.network(
                                                "images/ukp.png",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else {
                  // TODO: position this text vertically in the center of the screen
                  return Text(
                    "You don't have any events in your wishlist yet, go add some!",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: grey,
                    ),
                    textAlign: center,
                  );
                }
              },
            ),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
