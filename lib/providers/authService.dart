import 'dart:collection';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/models/newTask.dart';
import 'package:http/http.dart' as http;

class AuthService with ChangeNotifier {
  String? uid;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<NewTask> _tasks = [];
  List<NewTask> _initialTasks = [];
  // Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  // String? uid;
  // SharedPreferenceProvider();

  List<NewTask> get tasks => UnmodifiableListView(this._tasks);

  // List<NewTask> get tasks {
  //   return [..._tasks];
  // }

  AuthService();

  Future<bool> signInAnony() async {
    try {
      final result = await this._auth.signInAnonymously();
      final user = result.user;
      print("${user!.uid}----------");
      this.uid = user.uid;
      notifyListeners();
      return true;
    } catch (e) {
      this.uid = null;
      notifyListeners();
      return false;
    }
    // this.uid = "CV3yY06rdeZVw0dQQtCx90Hss9y2";
    // return true;
  }

  Future<void> addTask(NewTask addingTask) async {
    final url =
        "https://todo-flutter-11a3d-default-rtdb.firebaseio.com/${uid!}.json";
    String keyy = "";
    print(url);
    final response = await http
        .post(Uri.parse(url),
            body: json.encode({
              "id": addingTask.id,
              "task": addingTask.task,
              "taskFinished": addingTask.taskFinished,
              "date": addingTask.date,
              "list": addingTask.list,
              "repeat": addingTask.repeat
            }))
        .then((value) {
      keyy = value.body.split("\":\"")[1].split("\"}")[0];
      // print(value.body.split(": ")[1]);
      // final mm = value.body[0] as Map<String, String>?;
      // print(mm);
      // print(mm?["name"]);
      print(value.request);
      print("value - $value");
    });
    print("response");
    print(response);
    addingTask.uid = keyy;
    this._initialTasks.add(addingTask);
    this._tasks = this._initialTasks;
    notifyListeners();
  }

// --------------------------------
  Future<void> getTasks() async {
    final url =
        "https://todo-flutter-11a3d-default-rtdb.firebaseio.com/${uid!}.json";
    print(url);
    final response = await http.get(
      Uri.parse(url),
    );
    final formatted = json.decode(response.body) as Map<String, dynamic>?;

    if (formatted == null) {
      this._initialTasks = [];
      this._tasks = [];
      notifyListeners();
      return;
    }
    this._tasks = [];
    this._initialTasks = [];
    formatted.forEach((key, value) {
      print(key);
      print(value);
      this._initialTasks.add(NewTask(
          uid: key,
          id: value["id"],
          task: value["task"],
          taskFinished: value["taskFinished"],
          date: value["date"],
          repeat: value["repeat"],
          list: value["list"]));
    });
    this._tasks = this._initialTasks;
    notifyListeners();
    print("response $formatted");
    print(response);
    return;
    // notifyListeners();
  }

  Future<void> updateTask(NewTask updatedTask) async {
    final index = this
        ._initialTasks
        .indexWhere((element) => element.id == updatedTask.id);
    final particularElement =
        this._initialTasks.firstWhere((e) => e.id == updatedTask.id);

    final url =
        "https://todo-flutter-11a3d-default-rtdb.firebaseio.com/${uid!}/${particularElement.uid}.json";

    try {
      http.patch(Uri.parse(url),
          body: json.encode({
            // "uid": particularElement.uid,
            // "id": updatedTask.id,
            "task": updatedTask.task,
            "taskFinished": updatedTask.taskFinished,
            "date": updatedTask.date,
            "list": updatedTask.list,
            "repeat": updatedTask.repeat
          }));
      updatedTask.uid = particularElement.uid;
      this._initialTasks[index] = updatedTask;
      this._tasks = this._initialTasks;
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> toggleStatus(NewTask toggleTask, bool showAll) async {
    final index =
        this._initialTasks.indexWhere((element) => element.id == toggleTask.id);
    final particularElement =
        this._initialTasks.firstWhere((element) => element.id == toggleTask.id);

    final url =
        "https://todo-flutter-11a3d-default-rtdb.firebaseio.com/${uid!}/${particularElement.uid}.json";

    try {
      http.patch(Uri.parse(url),
          body: json.encode({
            // "id": toggleTask.id,
            "task": toggleTask.task,
            "taskFinished": toggleTask.taskFinished,
            "date": toggleTask.date,
            "list": toggleTask.list,
            "repeat": toggleTask.repeat
          }));
      this._initialTasks[index] = toggleTask;
      if (showAll) {
        this._tasks = this._initialTasks;
        notifyListeners();
      } else {
        this.getFinishedTasks();
        notifyListeners();
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> getFinishedTasks() async {
    this._tasks =
        this._initialTasks.where((e) => e.taskFinished == true).toList();
    notifyListeners();
  }

  Future<void> resetToAll() async {
    this._tasks = this._initialTasks;
    notifyListeners();
  }
}
