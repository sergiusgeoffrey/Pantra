import 'package:flutter/material.dart';
import 'package:pantra_project/widget/text.dart';

import '../utils/alignment.dart';
import '../utils/color.dart';
import '../utils/font_weight.dart';

class StudentDetailWidget extends StatelessWidget {
  final String strJudul;
  final String isiSnapshot;

  const StudentDetailWidget(
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
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
      ],
    );
  }
}
