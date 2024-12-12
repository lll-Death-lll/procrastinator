import 'package:flutter/material.dart';
import 'package:procrastinator/features/daily-tasks/domain/daily_tasks.dart';
import 'package:procrastinator/features/daily-tasks/presentation/widgets/task_card_rounded.dart';
import 'package:procrastinator/features/tasks/domain/sort_tasks_by.dart';
import 'package:procrastinator/features/tasks/domain/task.dart';
import 'package:procrastinator/features/tasks/presentation/widgets/task_sort.dart';

class SelectDailyTasks extends StatefulWidget {
  final List<Task> tasks;
  final Set<int> selected;
  const SelectDailyTasks(
      {super.key, required this.tasks, required this.selected});

  @override
  State<SelectDailyTasks> createState() => _SelectDailyTasksState();
}

class _SelectDailyTasksState extends State<SelectDailyTasks> {
  List<Task> tasks = [];
  Set<int> selectedIds = {};

  @override
  void initState() {
    super.initState();
    tasks = widget.tasks;
    selectedIds = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          'Select daily tasks',
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
        ],
        backgroundColor: Colors.grey[900],
      ),
      floatingActionButton: TextButton.icon(
        onPressed: () async {
          setDailyTasks(selectedIds);
          Navigator.pop(context);
        },
        label: const Text(
          'Choose selected',
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(
          Icons.navigate_next,
          color: Colors.white,
        ),
        style: TextButton.styleFrom(backgroundColor: Colors.deepPurple),
      ),
      backgroundColor: Colors.grey[850],
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
            itemCount: tasks.length,
            itemBuilder: (BuildContext context, int index) {
              return TaskCardRounded(
                task: tasks[index],
                isSelected: selectedIds.contains(tasks[index].id),
                onCheck: (isChecked) {
                  if (isChecked) {
                    setState(() {
                      selectedIds.add(tasks[index].id);
                    });
                  } else {
                    setState(() {
                      selectedIds.remove(tasks[index].id);
                    });
                  }
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) => Divider(
              color: Colors.grey[600],
            ),
          )),
    );
  }
}
