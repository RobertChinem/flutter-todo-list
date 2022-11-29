import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:todo_list/models/task.dart';

class Tasks with ChangeNotifier {
  final headers = {'Content-Type': 'application/json; charset=UTF-8'};
  List<Task> items = [];

  Tasks() {
    loadTasks();
  }

  List<Task> get all {
    return items;
  }

  int get count {
    return items.length;
  }

  Task byIndex(int i) {
    return items[i];
  }

  Future<void> loadTasks() async {
    var url = Uri.http('localhost:3001', 'tasks');
    var response = await http.get(url);
    List<dynamic> data = json.decode(response.body);
    items = data.map((task) => Task.fromJson(task)).toList();
    notifyListeners();
  }

  void put(Task task, bool newTask) async {
    if (newTask) {
      var url = Uri.http('localhost:3001', 'tasks');
      await http.post(
        url,
        body: jsonEncode(<String, dynamic>{
          'title': task.title,
          'description': task.description,
          'done': task.done,
        }),
        headers: headers,
      );
    } else {
      var url = Uri.http('localhost:3001', 'tasks/${task.id}');
      await http.put(
        url,
        body: jsonEncode(<String, dynamic>{
          'title': task.title,
          'description': task.description,
          'done': task.done,
        }),
        headers: headers,
      );
    }
    loadTasks();
  }

  Future<void> remove(Task task) async {
    var url = Uri.http('localhost:3001', 'tasks/${task.id}');
    await http.delete(url);
    loadTasks();
  }
}
