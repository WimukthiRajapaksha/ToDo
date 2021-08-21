import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String titleText;

  const TitleWidget({Key? key, required this.titleText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // height: 25,
      // color: Colors.greenAccent,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Text(
          this.titleText,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.red, fontSize: 16),
        ),
      ),
    );
  }
}
