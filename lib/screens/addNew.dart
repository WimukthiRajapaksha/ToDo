import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/models/newTask.dart';
import 'package:to_do_list/providers/authService.dart';
import 'package:to_do_list/screens/designs/common.dart';
import 'package:to_do_list/screens/widgets/AppBarDecorationWidget.dart';
import 'package:to_do_list/screens/widgets/DueDateFormWidget.dart';
import 'package:to_do_list/screens/widgets/TaskNameFormWidget.dart';

class AddNew extends StatefulWidget {
  static const routeName = "/add-new";

  @override
  _AddNewState createState() => _AddNewState();
}

class _AddNewState extends State<AddNew> {
  final _formKey = GlobalKey<FormState>();
  String? task;
  bool taskFinished = false;
  String? date;
  String? time;

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
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void _taskPassedFunction(String input) {
    print("input task $input");
    this.task = input;
  }

  void _taskFinishedPassedFunction(bool input) {
    print("input task finished $input");
    this.taskFinished = input;
  }

  void _datePassedFunction(String input) {
    print("input date $input");
    this.date = input;
  }

  void _timePassedFunction(String input) {
    print("input time $input");
    this.time = input;
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as NewTask?;

    this._currentList = (this._currentList != null)
        ? this._currentList
        : ((args?.list != null) ? args?.list : this.listTypes[0]);
    this.currentRepeat = (this.currentRepeat != null)
        ? this.currentRepeat
        : ((args?.repeat != null) ? args?.repeat : this.repeatTypes[0]);
    this.taskFinished =
        (this.taskFinished) ? this.taskFinished : args?.taskFinished ?? false;

    print("argument ${args?.date}");
    print((args?.date != null && args?.date != ""));

    final provi = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        flexibleSpace: AppBarDecorationWidget(),
        title: (args == null)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("New Task"),
                ],
              )
            : null,
        actions: (args != null)
            ? [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.share),
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.delete))
              ]
            : [],
      ),
      body: Container(
        decoration: Common.backgroundGradientDecoration(),
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
        width: double.infinity,
        height: double.infinity,
        // color: Colors.indigo[900],
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TaskNameFormWidget(
                  taskName: args?.task,
                  taskNameFormHandler: this._taskPassedFunction,
                  taskFinished: this.taskFinished,
                  taskFinishedFormHandler: this._taskFinishedPassedFunction,
                ),
                SizedBox(
                  height: 50,
                ),
                DueDateFormWidget(
                    dueDate: args?.date,
                    dueDateFormHandler: this._datePassedFunction,
                    dueTimeFormHandler: this._timePassedFunction),
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
                                            this._newListNameController.text =
                                                "";
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("CANCEL"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            this.listTypes.add(this
                                                ._newListNameController
                                                .text);
                                            setState(() {
                                              this._currentList = this
                                                  ._newListNameController
                                                  .text;
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
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();

            print("data");
            print(this.task);
            print(this.taskFinished);
            print(this.date?.split(" ")[0]);
            print(this.time);
            print(this.currentRepeat);
            print(this._currentList);

            if (args != null) {
              final newTask = NewTask(
                  id: args.id,
                  task: this.task ?? "",
                  taskFinished: this.taskFinished,
                  date: (this.date != "" && this.date != null)
                      ? "${this.date?.split(" ")[0]}, ${this.time?.trim()}"
                      : "",
                  repeat: this.currentRepeat ?? "",
                  list: this._currentList ?? "");
              print("args != null");
              provi.updateTask(newTask);
              Navigator.pop(context);
              // .then((value) => {Navigator.pop(context)});
            } else {
              final newTask = NewTask(
                  id: DateTime.now().toString(),
                  task: this.task ?? "",
                  taskFinished: this.taskFinished,
                  date: (this.date != "" && this.date != null)
                      ? "${this.date?.split(" ")[0]}, ${this.time?.trim()}"
                      : "",
                  repeat: this.currentRepeat ?? "",
                  list: this._currentList ?? "");
              print("args == null");
              print("++++++++++");
              print(provi.uid);
              provi.addTask(newTask);
              Navigator.pop(context);
              // .then((value) => {Navigator.pop(context)});
            }

            // if (args != null) {
            // print(this);
            // final newTask = NewTask(
            //     id: DateTime.now().toString(),
            //     task: this.task!,
            //     date:
            //         "${this._dateController.text.trim()}, ${this._timeController.text.trim()}",
            //     repeat: this.repeatType,
            //     list: this.listType);
            // provi
            //     .updateTask(newTask)
            //     // .then((value) => ScaffoldMessenger.of(context)
            //     // ..removeCurrentSnackBar()
            //     // ..showSnackBar(SnackBar(content: Text('Item added'))))
            //     .then((value) => Navigator.pop(context));
            // } else {
            // final newTask = NewTask(
            //     id: DateTime.now().toString(),
            //     task: this.task!,
            //     date:
            //         "${this._dateController.text.trim()}, ${this._timeController.text.trim()}",
            //     repeat: this.repeatType,
            //     list: this.listType);
            // print("id - ${newTask.id}");
            // provi
            //     .addTask(newTask)
            //     // .then((value) => ScaffoldMessenger.of(context)
            //     // ..removeCurrentSnackBar()
            //     // ..showSnackBar(SnackBar(content: Text('Item added'))))
            //     .then((value) => {
            //           // Navigator.pop(context)
            //         });
            // }
          }
        },
        child: Icon(
          Icons.done,
          color: Colors.blue[400],
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
