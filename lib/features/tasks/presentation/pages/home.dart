import 'package:flutter/material.dart';
import 'package:procrastinator/features/tasks/presentation/pages/add_task.dart';
import 'package:procrastinator/features/tasks/data/data_sources/task.dart';
import 'package:procrastinator/features/tasks/domain/task.dart';
import 'package:procrastinator/features/tasks/presentation/widgets/task_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Task> tasks = getAllTasks();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      floatingActionButton: TextButton.icon(
        onPressed: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddTask(onAdd: (task) {
                        saveTask(task);
                        setState(() {
                          tasks.add(task);
                        });
                      })));
        },
        label: const Text(
          'Add task',
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        style: TextButton.styleFrom(backgroundColor: Colors.deepPurple),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TaskList(
          tasks: tasks,
          onCheck: (index, completed) {
            if (completed) {
              completeTask(tasks[index].id);
              setState(() {
                tasks[index].completedAt = DateTime.now();
              });
            } else {
              removeTaskCompletion(tasks[index].id);
              setState(() {
                tasks[index].completedAt = null;
              });
            }
          },
          onUpdate: (index, task) {
            updateTask(task);
            setState(() {
              tasks[index] = task;
            });
          },
        ),
      ),
    );
  }
}
