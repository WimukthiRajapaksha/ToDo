import 'package:flutter/material.dart';
import 'package:to_do_list/screens/designs/common.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: Common.backgroundGradientDecoration(),
        child: Center(
          child: Image.asset(
            "assets/images/checkmark.png",
            height: 80.0,
          ),
        ),
      ),
    );
  }
}
