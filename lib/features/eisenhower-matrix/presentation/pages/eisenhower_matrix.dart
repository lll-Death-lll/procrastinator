import 'package:flutter/material.dart';
import 'package:procrastinator/features/eisenhower-matrix/presentation/widgets/matrix.dart';
import 'package:procrastinator/features/tasks/data/data_sources/task.dart';
import 'package:procrastinator/features/tasks/data/repository/database.dart';
import 'package:procrastinator/features/tasks/domain/task.dart';
import 'package:procrastinator/features/tasks/domain/task_priority.dart';
import 'package:procrastinator/features/tasks/domain/task_urgency.dart';

class EisenhowerMatrix extends StatefulWidget {
  const EisenhowerMatrix({super.key});

  @override
  State<EisenhowerMatrix> createState() => _EisenhowerMatrixState();
}

class _EisenhowerMatrixState extends State<EisenhowerMatrix> {
  List<Task> tasksUrgentImportant = [];
  List<Task> tasksNotUrgentImportant = [];
  List<Task> tasksUrgentNotImportant = [];
  List<Task> tasksNotUrgentNotImportant = [];

  @override
  void initState() {
    super.initState();
    refreshTasks();
  }

  void refreshTasks() {
    getTasksBy(TasksQuery(
            urgency: FieldQuery(Urgency.high, true),
            priority: FieldQuery(Priority.high, true)))
        .then((newTasks) {
      setState(() {
        tasksUrgentImportant = newTasks;
      });
    });

    getTasksBy(TasksQuery(
            urgency: FieldQuery(Urgency.high, false),
            priority: FieldQuery(Priority.high, true)))
        .then((newTasks) {
      setState(() {
        tasksNotUrgentImportant = newTasks;
      });
    });

    getTasksBy(TasksQuery(
            urgency: FieldQuery(Urgency.high, true),
            priority: FieldQuery(Priority.high, false)))
        .then((newTasks) {
      setState(() {
        tasksUrgentNotImportant = newTasks;
      });
    });

    getTasksBy(TasksQuery(
            urgency: FieldQuery(Urgency.high, false),
            priority: FieldQuery(Priority.high, false)))
        .then((newTasks) {
      setState(() {
        tasksNotUrgentNotImportant = newTasks;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: Colors.grey[900],
        ),
        backgroundColor: Colors.grey[850],
        body: Center(
            child: Matrix(
          tasksUrgentImportant: tasksUrgentImportant,
          tasksNotUrgentImportant: tasksNotUrgentImportant,
          tasksUrgentUnimportant: tasksUrgentNotImportant,
          tasksNotUrgentUnimportant: tasksNotUrgentNotImportant,
          onCheck: (id, completed) async {
            if (completed) {
              await completeTask(id);
            } else {
              await removeTaskCompletion(id);
            }
            refreshTasks();
          },
          onUpdate: (id, task) async {
            await updateTask(id, task);
            refreshTasks();
          },
          onDelete: (id) async {
            await removeTask(id);
            refreshTasks();
          },
        )));
  }
}
