import 'package:flutter/material.dart';
import 'package:procrastinator/features/daily-tasks/domain/daily_tasks.dart';
import 'package:procrastinator/features/daily-tasks/presentation/pages/select_daily_tasks.dart';
import 'package:procrastinator/features/tasks/data/data_sources/task.dart';
import 'package:procrastinator/features/tasks/domain/sort_tasks_by.dart';
import 'package:procrastinator/features/tasks/domain/task.dart';
import 'package:procrastinator/features/tasks/presentation/widgets/task_list.dart';
import 'package:procrastinator/features/tasks/presentation/widgets/task_sort.dart';

class DailyTasks extends StatefulWidget {
  const DailyTasks({super.key});

  @override
  State<DailyTasks> createState() => _DailyTasksState();
}

class _DailyTasksState extends State<DailyTasks> {
  List<Task> tasks = [];
  SortTasksBy sorting = SortTasksBy.id;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      var daily = await getDailyTasksIds();
      var allTasks = await getAllTasks();
      if (daily.isEmpty) {
        if (!mounted) return;
        await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SelectDailyTasks(tasks: allTasks, selected: daily)));
        var dailyTasks = await getDailyTasks();
        if (dailyTasks.isEmpty) {
          if (!mounted) return;
          Navigator.pop(context);
        }
        setState(() {
          tasks = dailyTasks;
        });
      } else {
        var newTasks = await getDailyTasks();
        setState(() {
          tasks = newTasks;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          'Daily tasks',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TaskSort(
            icon: const Icon(
              Icons.sort,
              color: Colors.white,
            ),
            onChanged: (sorting) {
              setState(() {
                switch (sorting) {
                  case SortTasksBy.id:
                    tasks.sortById();
                    break;
                  case SortTasksBy.name:
                    tasks.sortByName();
                    break;
                  case SortTasksBy.priority:
                    tasks.sortByPriority();
                    break;
                  case SortTasksBy.urgency:
                    tasks.sortByUrgency();
                    break;
                  case SortTasksBy.eta:
                    tasks.sortByETA();
                    break;
                }
              });
            },
          ),
          TaskSort(
            icon: Transform.flip(
              flipY: true,
              child: const Icon(
                Icons.sort,
                color: Colors.white,
              ),
            ),
            onChanged: (sorting) {
              setState(() {
                switch (sorting) {
                  case SortTasksBy.id:
                    tasks.sortByIdReverse();
                    break;
                  case SortTasksBy.name:
                    tasks.sortByNameReverse();
                    break;
                  case SortTasksBy.priority:
                    tasks.sortByPriorityReverse();
                    break;
                  case SortTasksBy.urgency:
                    tasks.sortByUrgencyReverse();
                    break;
                  case SortTasksBy.eta:
                    tasks.sortByETAReverse();
                    break;
                }
              });
            },
          ),
          IconButton(
              onPressed: () async {
                var daily = tasks.map((t) => t.id).toSet();
                var allTasks = await getAllTasks();
                await Navigator.push(
                    // ignore: use_build_context_synchronously
                    context,
                    MaterialPageRoute(
                        builder: (context) => SelectDailyTasks(
                            tasks: allTasks, selected: daily)));
                var newTasks = await getDailyTasks();
                setState(() {
                  tasks = newTasks;
                });
              },
              icon: const Icon(
                Icons.replay,
                color: Colors.white,
              ))
        ],
        backgroundColor: Colors.grey[900],
      ),
      backgroundColor: Colors.grey[850],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TaskList(
          tasks: tasks,
          onCheck: (id, completed) async {
            if (completed) {
              completeTask(id);
            } else {
              removeTaskCompletion(id);
            }

            var newTasks = await getAllTasks();
            setState(() {
              tasks = newTasks;
            });
          },
          onUpdate: (id, task) async {
            updateTask(id, task);
            var newTasks = await getAllTasks();
            setState(() {
              tasks = newTasks;
            });
          },
        ),
      ),
    );
  }
}
