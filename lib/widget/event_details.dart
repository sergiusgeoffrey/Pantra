import 'package:flutter/material.dart';
import 'package:pantra_project/widget/text.dart';
import 'package:pantra_project/utils/alignment.dart';
import 'package:pantra_project/utils/color.dart';
import 'package:pantra_project/utils/font_weight.dart';

class EventDetailWidget extends StatelessWidget {
  final String strJudul;
  final String isiSnapshot;

  const EventDetailWidget(
      {Key? key, required this.strJudul, required this.isiSnapshot})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextWidget(
          str: strJudul,
          size: MediaQuery.of(context).size.height * 0.02,
          color: black,
          weight: bold,
          alignment: center,
        ),
        TextWidget(
          str: isiSnapshot,
          size: MediaQuery.of(context).size.height * 0.025,
          color: primary,
          weight: bold,
          alignment: center,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
