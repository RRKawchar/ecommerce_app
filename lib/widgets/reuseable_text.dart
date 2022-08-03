import 'package:flutter/material.dart';

Widget ReuseableText(
    String text, double size, Color color, FontWeight fontWeight) {
  return Text(
    text,
    style: TextStyle(
      fontSize: size,
      color: color,
      fontWeight: fontWeight,
    ),
  );
}
