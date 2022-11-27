import 'dart:math';

import 'package:flutter/material.dart';
import 'package:todo_list/data/dummy_tasks.dart';
import 'package:todo_list/models/task.dart';

class Tasks with ChangeNotifier {
  final Map<String, Task> _items = {...dummyTasks};

  List<Task> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  Task byIndex(int i) {
    return _items.values.elementAt(i);
  }

  void put(Task task) {
    final id = Random().nextDouble().toString();

    if (task.id != '' &&
        task.id.trim().isNotEmpty &&
        _items.containsKey(task.id)) {
      _items.update(
          task.id,
          (_) => Task(
              id: task.id,
              title: task.title,
              description: task.description,
              done: task.done));
    } else {
      _items.putIfAbsent(
          id,
          () => Task(
              id: id,
              title: task.title,
              description: task.description,
              done: task.done));
    }
    notifyListeners();
  }

  void remove(Task task) {
    if (task.id != '' && task.id.trim().isNotEmpty) {
      _items.remove(task.id);
      notifyListeners();
    }
  }
}
