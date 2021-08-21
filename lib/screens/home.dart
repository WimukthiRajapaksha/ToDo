import 'dart:io' as IO;

import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/models/newTask.dart';
import 'package:to_do_list/providers/authService.dart';
import 'package:to_do_list/screens/addNew.dart';
import 'package:to_do_list/screens/designs/common.dart';
import 'package:to_do_list/screens/widgets/AppBarDecorationWidget.dart';
import 'package:to_do_list/screens/widgets/TileItemWidget.dart';
import 'package:to_do_list/screens/widgets/TitleWidget.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  static const routeName = "/home";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _qTEController = TextEditingController();
  bool _enableQT = false;
  List<String> _listOfItems = ["All Lists", "Finished" /*, "New List"*/];
  String titleText = "All items you're having";
  late String selectedList;
  late Future tasksFuture;

  // Future _obtainOrdersFuture() {
  //   return Provider.of<SharedPreferenceProvider>(context, listen: false)
  //       .getTasks();
  // }

  @override
  void initState() {
    super.initState();
    this.tasksFuture =
        Provider.of<AuthService>(context, listen: false).getTasks();
    // provi.signInAnony();
    // this._obtainOrdersFuture();
    // authService.signInAnony();
    _qTEController.addListener(() {
      if (_qTEController.text.isNotEmpty && _qTEController.text.trim() != "") {
        setState(() {
          _enableQT = true;
        });
      } else {
        setState(() {
          _enableQT = false;
        });
      }
    });
    this.selectedList = _listOfItems[0];
  }

  @override
  Widget build(BuildContext context) {
    print("...........Home");
    final provi = Provider.of<AuthService>(context, listen: false);
    // // provi.signInAnony().then((value) => {
    // if (this.selectedList == this._listOfItems[0]) {
    //   provi.getTasks();
    //   //   // tasks = provi.tasks;
    // } else if (this.selectedList == this._listOfItems[1]) {
    //   // provi.finishedTasks();
    //   //   // tasks = provi.tasks.where((element) => element.taskFinished).toList();
    // } else {
    //   // provi.newListTasks();
    //   //   // tasks = [];
    // }
    // // }
    // // // );
    var _checked = false;
    final List<NewTask> tasks;

    // tasks = provi.tasks;

    return Scaffold(
      appBar: AppBar(
        leading: Center(
          child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.done,
                color: Colors.blue,
              )),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          // children: [Text("All Lists"), Icon(Icons.arrow_drop_down)],
          children: [
            Container(
              width: 100,
              child: DropdownButton(
                isExpanded: true,
                dropdownColor: Colors.blue,
                iconEnabledColor: Colors.white,
                value: this.selectedList,
                items: this
                    ._listOfItems
                    .map((e) => DropdownMenuItem(
                          child: Row(
                            children: [
                              Icon(e == this._listOfItems[0]
                                  ? Icons.home
                                  : (e == this._listOfItems[1]
                                      ? Icons.list
                                      : Icons.playlist_add)),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                e,
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          value: e,
                        ))
                    .toList(),
                selectedItemBuilder: (BuildContext context) {
                  return this
                      ._listOfItems
                      .map((e) => Container(
                            child: Center(
                              child: Text(
                                e,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ))
                      .toList();
                },
                onChanged: (String? value) {
                  setState(() {
                    this.selectedList = value!;
                  });
                  if (this.selectedList == this._listOfItems[0]) {
                    setState(() {
                      this.titleText = "All items you're having";
                    });
                    provi.resetToAll();
                  } else {
                    setState(() {
                      this.titleText = "Finished items you're having";
                    });
                    provi.getFinishedTasks();
                  }
                },
              ),
            )
          ],
        ),
        flexibleSpace: AppBarDecorationWidget(),
        actions: [
          // IconButton(
          //     onPressed: () {
          //       provi.getTasks();
          //     },
          //     icon: Icon(Icons.search)),
          // IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            color: Colors.blue,
            itemBuilder: (ctx) => [
              // PopupMenuItem(
              //   child: Text(
              //     "Task Lists",
              //     style: TextStyle(color: Colors.white),
              //   ),
              //   value: 0,
              // ),
              // PopupMenuItem(
              //   child: Text(
              //     "Add in Batch Mode",
              //     style: TextStyle(color: Colors.white),
              //   ),
              //   value: 1,
              // ),
              // PopupMenuItem(
              //   child: Text(
              //     "Remove Adds",
              //     style: TextStyle(color: Colors.white),
              //   ),
              //   value: 2,
              // ),
              PopupMenuItem(
                child: Text(
                  "More Apps",
                  style: TextStyle(color: Colors.white),
                ),
                value: 3,
              ),
              PopupMenuItem(
                child: Text(
                  "Send feedback",
                  style: TextStyle(color: Colors.white),
                ),
                value: 4,
              ),
              PopupMenuItem(
                child: Text(
                  "Follow Me",
                  style: TextStyle(color: Colors.white),
                ),
                value: 5,
              ),
              PopupMenuItem(
                child: Text(
                  "Settings",
                  style: TextStyle(color: Colors.white),
                ),
                value: 6,
              )
            ],
            onSelected: (int item) {
              // provi.removeTasks();
              if (item == 3) {
                LaunchReview.launch(
                    androidAppId: "com.iyaffle.rangoli",
                    iOSAppId: "585027354",
                    writeReview: false);
              } else if (item == 4) {
                this._openUrl(
                    "https://mail.google.com/mail/?view=cm&fs=1&to=wimukthirajapaksha.wr@gmail.com&su=ToDo-Feedback&body=Enter%20Feedback");
              } else if (item == 5) {
                this._openUrl(
                    "https://www.facebook.com/wimukthi.rajapaksha.wr");
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                  "Will update this section soon..",
                  style: TextStyle(color: Colors.white),
                )));
              }
              print(item);
            },
          ),
        ],
      ),
      body: FutureBuilder(
          future: this.tasksFuture,
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Container(
                  decoration: Common.backgroundGradientDecoration(),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ));
            } else {
              return Container(
                decoration: Common.backgroundGradientDecoration(),
                // child: Consumer<AuthService>(
                //     builder: (ctx, auth, child) =>
                //         _topBodyWidget(auth.tasks, _checked)),
                child: _topBodyWidget(_checked, this.titleText),
                width: double.infinity,
                height: double.infinity,
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddNew.routeName);
        },
        backgroundColor: Colors.white,
        child: Icon(
          Icons.add,
          color: Colors.blue[400],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.blue[400],
        height: 50,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                Icons.mic,
                color: Colors.white,
              ),
              SizedBox(
                width: 4,
              ),
              Expanded(
                child: TextField(
                  controller: _qTEController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Enter Quick Task Here",
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
                ),
              ),
              if (_enableQT)
                Container(
                  width: 30,
                  height: 30,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        final newTask = NewTask(
                            id: DateTime.now().toString(),
                            task: this._qTEController.text.trim(),
                            taskFinished: false,
                            date: "",
                            repeat: "No Repeat",
                            list: "Default");
                        provi.addTask(newTask);
                        this._qTEController.clear();
                        // .then((value) => {this._qTEController.clear()});
                      },
                      child: Icon(
                        Icons.done,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget _topBodyWidget(bool _checked, String titleText) {
    final provi = Provider.of<AuthService>(context, listen: false);

    print(provi.tasks.length);
    print("length");
    return (provi.tasks.length == 0)
        ? Center(
            child: Column(
              children: [
                Image.asset(
                  (IO.Platform.isAndroid)
                      ? "assets/images/android.png"
                      : "assets/images/ios.png",
                  width: 150,
                  height: 150,
                ),
                Text(
                  provi.tasks.length == 0
                      ? "Nothing to Show"
                      : "there are ${provi.tasks.length}",
                  style: TextStyle(color: Color.fromARGB(255, 183, 179, 255)),
                )
              ],
            ),
          )
        : ListView.builder(
            itemCount: provi.tasks.length + 1,
            itemBuilder: (BuildContext ctx, int index) {
              if (index == 0) {
                return TitleWidget(
                  titleText: titleText,
                );
              } else {
                return TileItemWidget(
                    task: provi.tasks[index - 1],
                    showAll: (this.selectedList == this._listOfItems[0])
                        ? true
                        : false);
              }
            },
          );
  }

  void _openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
