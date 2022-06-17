import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String str;
  final double size;
  final Color color;
  final FontWeight weight;
  final TextAlign alignment;
  
  const TextWidget({Key? key, required this.str, required this.size, required this.color, required this.weight, required this.alignment}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Text(
      str,
      textAlign: alignment,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: weight,
      ),
    );
  }

  
}