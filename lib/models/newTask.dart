import 'dart:convert';

class NewTask {
  String? uid;
  String? id;
  String task;
  bool taskFinished;
  String date;
  String list;
  String repeat;
  NewTask(
      {this.uid,
      required this.id,
      required this.task,
      required this.taskFinished,
      required this.date,
      required this.repeat,
      required this.list});

  void setTask(String task) {
    this.task = task;
  }

  void setDate(String newDate) {
    this.date = newDate;
  }

  void setList(String newList) {
    this.list = newList;
  }

  void setBoolFinished(bool finished) {
    this.taskFinished = finished;
  }

  // factory NewTask.fromJson(Map<String, dynamic> jsonData) {
  //   return NewTask(
  //     id: jsonData['id'],
  //     task: jsonData['task'],
  //     taskFinished: jsonData["taskFinished"],
  //     date: jsonData['date'],
  //     repeat: jsonData['repeat'],
  //     list: jsonData['list'],
  //   );
  // }

  // static Map<String, dynamic> toMap(NewTask newTask) => {
  //       'id': newTask.id,
  //       'task': newTask.task,
  //       'taskFinished': newTask.taskFinished,
  //       'date': newTask.date,
  //       'repeat': newTask.repeat,
  //       'list': newTask.list
  //     };

  // static String encode(List<NewTask> newTask) => json.encode(
  //       newTask
  //           .map<Map<String, dynamic>>((music) => NewTask.toMap(music))
  //           .toList(),
  //     );

  // static List<NewTask> decode(String newtask) =>
  //     (json.decode(newtask) as List<dynamic>)
  //         .map<NewTask>((item) => NewTask.fromJson(item))
  //         .toList();
}
