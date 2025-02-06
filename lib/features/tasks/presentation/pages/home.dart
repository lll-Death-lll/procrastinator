import 'package:flutter/material.dart';
import 'package:procrastinator/features/tasks/domain/sort_tasks_by.dart';
import 'package:procrastinator/features/tasks/presentation/pages/add_task.dart';
import 'package:procrastinator/features/tasks/data/data_sources/task.dart';
import 'package:procrastinator/features/tasks/domain/task.dart';
import 'package:procrastinator/features/tasks/presentation/widgets/task_list.dart';
import 'package:procrastinator/features/tasks/presentation/widgets/task_sort.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    getAllTasks().then((newTasks) {
      setState(() {
        tasks = newTasks;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.grey[900],
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton.icon(
                    onPressed: () async {
                      await Navigator.pushNamed(context, '/daily');
                      var newTasks = await getAllTasks();
                      setState(() {
                        tasks = newTasks;
                      });
                    },
                    label: Text(
                      "Daily",
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    icon: Icon(
                      Icons.sunny,
                      size: 24,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextButton.icon(
                    onPressed: () async {
                      await Navigator.pushNamed(context, '/matrix');
                      var newTasks = await getAllTasks();
                      setState(() {
                        tasks = newTasks;
                      });
                    },
                    label: Text(
                      "Matrix",
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    icon: Icon(
                      Icons.grid_view,
                      size: 24,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
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
                var newTasks = await getAllTasks();
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
          onDelete: (id) async {
            removeTask(id);
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
