import 'package:flutter/material.dart';
import '../utils/alignment.dart';
import '../utils/color.dart';
import '../utils/font_weight.dart';
import 'text.dart';

class TitleWidget extends StatelessWidget {
  final String str1;
  final String str2;
  const TitleWidget({Key? key, required this.str1, required this.str2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        TextWidget(
            str: str1,
            color: primary,
            size: MediaQuery.of(context).size.height * 0.04,
            weight: bold,
            alignment: center),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        TextWidget(
            str: str2,
            color: primary,
            size: MediaQuery.of(context).size.height * 0.02,
            weight: regular,
            alignment: center),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
      ],
    );
  }
}
