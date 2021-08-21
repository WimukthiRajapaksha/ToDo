import 'package:flutter/material.dart';

class AppBarDecorationWidget extends StatelessWidget {
  const AppBarDecorationWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blue.shade600, Colors.blue.shade800],
        ),
      ),
    );
  }
}
