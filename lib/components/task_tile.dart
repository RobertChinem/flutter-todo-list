import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/models/task.dart';
import 'package:todo_list/providers/tasks.dart';
import 'package:todo_list/routes/app_routes.dart';

class TaskTile extends StatelessWidget {
  final Task task;

  const TaskTile(this.task, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: task.done,
        onChanged: (value) {
          Provider.of<Tasks>(context, listen: false).put(Task(
            id: task.id,
            title: task.title,
            done: value!,
            description: task.description,
          ));
        },
      ),
      title: Text(task.title),
      subtitle: Text(task.description),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.edit),
              color: Colors.orange,
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.taskForm,
                  arguments: task,
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              color: Colors.red,
              onPressed: () {
                Provider.of<Tasks>(context, listen: false).remove(task);
              },
            ),
          ],
        ),
      ),
    );
  }
}
