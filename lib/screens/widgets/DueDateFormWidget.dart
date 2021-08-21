import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DueDateFormWidget extends StatefulWidget {
  final String? dueDate;
  final Function dueDateFormHandler;
  final Function dueTimeFormHandler;

  DueDateFormWidget(
      {required this.dueDate,
      required this.dueDateFormHandler,
      required this.dueTimeFormHandler});

  @override
  _DueDateFormWidgetState createState() => _DueDateFormWidgetState();
}

class _DueDateFormWidgetState extends State<DueDateFormWidget> {
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();

  DateTime? _date;
  TimeOfDay? _timeOfDay;

  @override
  void initState() {
    super.initState();
    if (widget.dueDate != null &&
        widget.dueDate != "" &&
        widget.dueDate?.split(",")[1].trim() == "") {
      this._date = DateFormat("yyyy-MM-dd,").parse(widget.dueDate!);
      this._timeOfDay = null;
    } else if (widget.dueDate != null && widget.dueDate != "") {
      this._date = DateFormat("yyyy-MM-dd, hh:mm aaa").parse(widget.dueDate!);
      this._timeOfDay = TimeOfDay.fromDateTime(this._date!);
    } else {
      this._date = null;
      this._timeOfDay = null;
    }
    print("object ${widget.dueDate}");
    print("object ${this._date}");
    // print("object ${this._timeOfDay}");
  }

  Future<DateTime?> _selectDate(DateTime? dateTimeDefault) async {
    this._timeOfDay = null;
    var date = await showDatePicker(
        context: context,
        initialDate: dateTimeDefault ?? DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2022));
    setState(() {
      if (date != null) {
        this._date = date;
        // this._dateController.text = DateFormat('yyyy-MM-dd').format(date);
      }
    });
  }

  Future<DateTime?> _selectTime(TimeOfDay? timeOfDayDefault) async {
    var time = await showTimePicker(
        context: context, initialTime: timeOfDayDefault ?? TimeOfDay.now());
    if (time != null) {
      setState(() {
        // this._date = DateTime(this._date!.year, this._date!.month,
        // this._date!.day, time.hashCode, time.minute);
        this._timeOfDay = time;
        // print("0000 ${this._date}    ${this._timeOfDay}");
        // this._timeController.text = time.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print("------------");
    print(this._date);
    print(this._timeOfDay);
    this._dateController.text = (this._date != null)
        ? DateFormat("yyyy-MM-dd").format(this._date!)
        : "";

    this._timeController.text =
        (this._timeOfDay != null) ? this._timeOfDay!.format(context) : "";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Due date",
          style:
              TextStyle(color: Colors.blue[200], fontWeight: FontWeight.w900),
        ),
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  this._selectDate(this._date);
                },
                child: IgnorePointer(
                  child: TextFormField(
                    controller: this._dateController,
                    onChanged: (value) {
                      print(value);
                    },
                    decoration: new InputDecoration(
                      hintText: 'Date not set',
                      labelStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(
                        color: Colors.white60,
                      ),
                      disabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white60),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white60),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue.shade50),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                    onSaved: (val) {
                      print(val);
                      widget.dueDateFormHandler("$val");
                    },
                  ),
                ),
              ),
            ),
            InkWell(
              child: Container(
                child: Icon(
                  Icons.calendar_today,
                  color: Colors.white,
                ),
                margin: EdgeInsets.only(left: 16, top: 16),
              ),
              onTap: () {
                this._selectDate(this._date);
              },
            ),
            InkWell(
              onTap: () {
                setState(() {
                  this._date = null;
                });
              },
              child: Container(
                margin: EdgeInsets.only(left: 16, top: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Icon(
                  Icons.close_rounded,
                  size: 20,
                ),
              ),
            )
          ],
        ),
        (this._dateController.text != "")
            ? Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        this._selectTime(this._timeOfDay);
                      },
                      child: IgnorePointer(
                        child: TextFormField(
                          controller: this._timeController,
                          onChanged: (value) {
                            print(value);
                          },
                          decoration: new InputDecoration(
                            hintText: 'Time not set (all day)',
                            labelStyle: TextStyle(color: Colors.white),
                            hintStyle: TextStyle(
                              color: Colors.white60,
                            ),
                            disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white60),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white60),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue.shade50),
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                          onSaved: (val) {
                            print(val);
                            widget.dueTimeFormHandler(val);
                          },
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    child: Container(
                      child: Icon(
                        Icons.access_time,
                        color: Colors.white,
                      ),
                      margin: EdgeInsets.only(left: 16, top: 16),
                    ),
                    onTap: () {
                      this._selectTime(this._timeOfDay);
                    },
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        this._timeOfDay = null;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 16, top: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Icon(
                        Icons.close_rounded,
                        size: 20,
                      ),
                    ),
                  )
                ],
              )
            : Container(),
        Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 8),
          child: GestureDetector(
            onTap: () {
              final snackBar = SnackBar(
                content: const Text(
                    'Want to customize notifications?\nGo to Settings.'),
                action: SnackBarAction(
                  label: 'SETTINGS',
                  onPressed: () {},
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Notifications",
                  style: TextStyle(
                      color: Colors.blue[200],
                      decoration: TextDecoration.underline),
                ),
                Text("No notifications if date not set.",
                    style: TextStyle(color: Colors.white60)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
