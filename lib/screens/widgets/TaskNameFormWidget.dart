import 'package:flutter/material.dart';

class TaskNameFormWidget extends StatefulWidget {
  final String? taskName;
  final Function taskNameFormHandler;
  final bool taskFinished;
  final Function taskFinishedFormHandler;

  TaskNameFormWidget({
    required this.taskName,
    required this.taskNameFormHandler,
    required this.taskFinished,
    required this.taskFinishedFormHandler,
  });

  @override
  _TaskNameFormWidgetState createState() => _TaskNameFormWidgetState();
}

class _TaskNameFormWidgetState extends State<TaskNameFormWidget> {
  bool _taskFinished = false;

  @override
  void initState() {
    this._taskFinished = widget.taskFinished;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "What is to be done?",
          style:
              TextStyle(color: Colors.blue[200], fontWeight: FontWeight.w900),
        ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                initialValue: widget.taskName,
                decoration: InputDecoration(
                  hintText: "Enter Task Here",
                  hintStyle: TextStyle(
                    color: Colors.white60,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white60),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue.shade50),
                  ),
                ),
                style: TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty || value.trim() == "") {
                    return "Enter task please!";
                  }
                  return null;
                },
                onSaved: (value) {
                  // this.taskName = value!;
                  widget.taskNameFormHandler(value);
                },
              ),
            ),
            Icon(
              Icons.keyboard_voice_rounded,
              color: Colors.white,
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Theme(
              data: Theme.of(context).copyWith(
                unselectedWidgetColor: Colors.white,
              ),
              child: Checkbox(
                value: this._taskFinished,
                onChanged: (value) {
                  setState(() {
                    print(value);
                    this._taskFinished = value!;
                  });
                  widget.taskFinishedFormHandler(value);
                },
              ),
            ),
            Text(
              "Task Finished?",
              style: TextStyle(
                  color: this._taskFinished ? Colors.blue[200] : Colors.white,
                  fontWeight:
                      this._taskFinished ? FontWeight.bold : FontWeight.normal),
            ),
          ],
        ),
      ],
    );
  }
}
