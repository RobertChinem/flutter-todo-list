import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/models/task.dart';
import 'package:todo_list/providers/tasks.dart';

class TaskForm extends StatelessWidget {
  TaskForm({super.key});
  final form = GlobalKey<FormState>();
  final Map<String, String> formData = {};

  void _loadFormData(Task? task) {
    if (task != null) {
      formData['id'] = task.id;
      formData['title'] = task.title;
      formData['description'] = task.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    final task = ModalRoute.of(context)!.settings.arguments as Task?;
    _loadFormData(task);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Task Form'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                final state = form.currentState;
                if (state == null) return;

                final isValid = state.validate();
                if (isValid) {
                  state.save();
                  Provider.of<Tasks>(context, listen: false).put(
                    Task(
                      title: formData['title']!,
                      description: formData['description']!,
                      done: false,
                      id: formData.containsKey('id') ? formData['id']! : '',
                    ),
                  );
                  Navigator.of(context).pop();
                }
              },
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
              key: form,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    initialValue: formData['title'],
                    decoration: const InputDecoration(labelText: 'Title'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Title is required';
                      }
                      return null;
                    },
                    onSaved: (newValue) => formData['title'] = newValue!,
                  ),
                  TextFormField(
                    initialValue: formData['description'],
                    decoration: const InputDecoration(labelText: 'Description'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Description is required';
                      }
                      return null;
                    },
                    onSaved: (newValue) => formData['description'] = newValue!,
                  )
                ],
              )),
        ));
  }
}
