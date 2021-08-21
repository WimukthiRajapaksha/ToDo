import 'package:flutter/material.dart';

class RepeatFormWidget extends StatefulWidget {
  final String? repeat;
  // final Function repeatFormHandler;

  RepeatFormWidget({required this.repeat
      // , required this.repeatFormHandler
      });

  @override
  _RepeatFormWidgetState createState() => _RepeatFormWidgetState();
}

class _RepeatFormWidgetState extends State<RepeatFormWidget> {
  String? currentRepeat;

  final List<String> repeatTypes = [
    "No Repeat",
    "Once a Day",
    "Once a Day(Mon-Fri)",
    "Once a Week",
    "Once a Month",
    "Once a Year",
    "Other..."
  ];

  @override
  void initState() {
    this.currentRepeat =
        (widget.repeat != null) ? widget.repeat : this.repeatTypes[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Repeat",
          style:
              TextStyle(color: Colors.blue[200], fontWeight: FontWeight.w900),
        ),
        Container(
          width: 200,
          child: DropdownButton(
              underline: Container(),
              isExpanded: true,
              dropdownColor: Colors.white,
              value: this.currentRepeat,
              // style: TextStyle(color: Colors.blue[200]),
              onChanged: (String? value) {
                // print(value);
                setState(() {
                  this.currentRepeat = value!;
                });
                // widget.repeatFormHandler(this.currentRepeat);
              },
              selectedItemBuilder: (BuildContext context) {
                return this.repeatTypes.map((String value) {
                  return Center(
                    child: Container(
                      width: double.infinity,
                      child: Text(
                        value,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                }).toList();
              },
              items: this
                  .repeatTypes
                  .map((item) => DropdownMenuItem(
                        child: Text(
                          item,
                          style: TextStyle(color: Colors.black),
                        ),
                        value: item,
                      ))
                  .toList()),
        ),
      ],
    );
  }
}
