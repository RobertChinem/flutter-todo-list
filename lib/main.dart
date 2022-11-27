import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/providers/tasks.dart';
import 'package:todo_list/routes/app_routes.dart';
import 'package:todo_list/views/task_form.dart';
import 'package:todo_list/views/task_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Tasks(),
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routes: {
            AppRoutes.home: (_) => const TaskList(),
            AppRoutes.taskForm: (_) => TaskForm(),
          }),
    );
  }
}
