import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/components/task_tile.dart';
import 'package:todo_list/providers/tasks.dart';
import 'package:todo_list/routes/app_routes.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    final Tasks tasks = Provider.of(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Lista de Tarefas'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.taskForm);
              },
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: tasks.count,
          itemBuilder: (ctx, i) => TaskTile(tasks.all.elementAt(i)),
        ));
  }
}
