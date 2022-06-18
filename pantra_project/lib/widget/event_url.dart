import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/alignment.dart';
import '../utils/color.dart';
import '../utils/font_weight.dart';
import 'text.dart';

class EventURLWidget extends StatelessWidget {
  final String URL;
  const EventURLWidget({Key? key, required this.URL}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextWidget(
          str: "Website or Instagram",
          size: MediaQuery.of(context).size.height * 0.02,
          color: black,
          weight: bold,
          alignment: center,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: secondary,
            ),
            onPressed: () async {
              await launchUrl(
                Uri.parse(URL),
              );
            },
            child: TextWidget(
              str: "See Website or Instagram",
              size: MediaQuery.of(context).size.height * 0.025,
              color: primary,
              weight: bold,
              alignment: center,
            ),
          ),
        ),
      ],
    );
  }
}
