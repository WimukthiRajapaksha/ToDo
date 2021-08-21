import 'package:flutter/material.dart';

class Common {
  static BoxDecoration backgroundGradientDecoration() {
    return BoxDecoration(
      gradient: new LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xff182e57), Color(0xff0b1c3b)],
      ),
    );
  }
}
