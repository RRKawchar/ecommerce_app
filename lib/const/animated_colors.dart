import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class AnimatedColors extends StatelessWidget {
  static const colorizeColors = [
    Colors.white,
    Colors.blue,
    Colors.purple,
    Colors.red,
  ];

  static const colorizeTextStyle = TextStyle(
    fontSize: 44.0,
    fontWeight: FontWeight.bold,
    fontFamily: 'Horizon',
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300.0,
        child: AnimatedTextKit(
          animatedTexts: [
            ColorizeAnimatedText(
              'E-Commerce',
              textStyle: colorizeTextStyle,
              colors: colorizeColors,
            ),
            ColorizeAnimatedText(
              'E-Commerce',
              textStyle: colorizeTextStyle,
              colors: colorizeColors,
            ),
            ColorizeAnimatedText(
              'E-Commerce',
              textStyle: colorizeTextStyle,
              colors: colorizeColors,
            ),
          ],
          isRepeatingAnimation: true,
        ),
      ),
    );
  }
}
