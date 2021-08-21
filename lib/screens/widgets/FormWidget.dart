import 'package:flutter/material.dart';
import 'package:to_do_list/models/newTask.dart';
import 'package:to_do_list/screens/widgets/DueDateFormWidget.dart';
import 'package:to_do_list/screens/widgets/ListToAddFormWidget.dart';
import 'package:to_do_list/screens/widgets/RepeatFormWidget.dart';
import 'package:to_do_list/screens/widgets/TaskNameFormWidget.dart';

class FormWidget extends StatefulWidget {
  final NewTask? task;
  final GlobalKey formKey;
  final Function formHandler;
  FormWidget({
    required this.task,
    required this.formKey,
    required this.formHandler,
  });

  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
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

  final _newListNameController = TextEditingController();

  final List<String> listTypes = [
    "Default",
    "Personal",
    "Shopping",
    "Wishlist",
    "Work"
  ];

  String? _currentList;

  @override
  void initState() {
    super.initState();
    this._currentList =
        (widget.task?.list != null) ? widget.task?.list : this.listTypes[0];
    this.currentRepeat = (widget.task?.repeat != null)
        ? widget.task?.repeat
        : this.repeatTypes[0];
  }

  void _passedFunction(String input) {
    print("input $input");
  }

  @override
  Widget build(BuildContext context) {
    // print(RepeatFormWidget.)
    return Form(
      key: this.widget.formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TaskNameFormWidget(
            //   taskName: widget.task?.task,
            //   taskNameFormHandler: this._passedFunction,
            // ),
            SizedBox(
              height: 50,
            ),
            DueDateFormWidget(
              dueDate: widget.task?.date,
              dueDateFormHandler: this._passedFunction,
              dueTimeFormHandler: this._passedFunction,
            ),
            SizedBox(
              height: 50,
            ),
            // RepeatFormWidget(
            //   repeat: widget.task?.repeat,
            //   repeatFormHandler: this._passedFunction,
            // ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Repeat",
                  style: TextStyle(
                      color: Colors.blue[200], fontWeight: FontWeight.w900),
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
            ),
            SizedBox(
              height: 50,
            ),
            // ListToAddFormWidget(
            //   listToAdd: widget.task?.list,
            //   listToAddFormHandler: this._passedFunction,
            // ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add to List",
                  style: TextStyle(
                      color: Colors.blue[200], fontWeight: FontWeight.w900),
                ),
                Row(
                  children: [
                    Expanded(
                      // width: 200,
                      child: DropdownButton<String>(
                          underline: Container(),
                          isExpanded: true,
                          dropdownColor: Colors.white,
                          value: this._currentList,
                          // style: TextStyle(color: Colors.blue[200]),
                          onChanged: (String? value) {
                            // print(value);
                            setState(() {
                              this._currentList = value!;
                            });
                          },
                          selectedItemBuilder: (BuildContext context) {
                            return this.listTypes.map((String value) {
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
                              .listTypes
                              .map((item) => DropdownMenuItem(
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    value: item,
                                  ))
                              .toList()),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: InkWell(
                        child: Icon(
                          Icons.playlist_add,
                          color: Colors.white,
                        ),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext ctx) {
                                return AlertDialog(
                                  title: Text(
                                    "New List",
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                  content: TextField(
                                    controller: this._newListNameController,
                                    decoration: InputDecoration(
                                        hintText: "Enter List Name"),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        this._newListNameController.text = "";
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("CANCEL"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        this.listTypes.add(
                                            this._newListNameController.text);
                                        setState(() {
                                          this._currentList =
                                              this._newListNameController.text;
                                        });
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("ADD"),
                                    )
                                  ],
                                );
                              });
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}
