import 'package:flutter/material.dart';
import 'package:procrastinator/features/eisenhower-matrix/presentation/widgets/clear_task_list.dart';
import 'package:procrastinator/features/tasks/domain/task.dart';

class Matrix extends StatelessWidget {
  final List<Task> tasksUrgentImportant;
  final List<Task> tasksNotUrgentImportant;
  final List<Task> tasksUrgentUnimportant;
  final List<Task> tasksNotUrgentUnimportant;

  const Matrix(
      {super.key,
      required this.tasksUrgentImportant,
      required this.tasksNotUrgentImportant,
      required this.tasksUrgentUnimportant,
      required this.tasksNotUrgentUnimportant});

  @override
  Widget build(BuildContext context) {
    // todo Add text on the sides or colors/icons
    return AspectRatio(
      aspectRatio: 1 / 1,
      child: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16),
        primary: false,
        shrinkWrap: false,
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(border: Border.all(color: Colors.white)),
            child: ClearTaskList(
              tasks: tasksUrgentImportant,
              onCheck: (id, isCompleted) {},
              onDelete: (id) {},
              onUpdate: (id, task) {},
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(border: Border.all(color: Colors.white)),
            child: ClearTaskList(
              tasks: tasksNotUrgentImportant,
              onCheck: (id, isCompleted) {},
              onDelete: (id) {},
              onUpdate: (id, task) {},
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(border: Border.all(color: Colors.white)),
            child: ClearTaskList(
              tasks: tasksUrgentUnimportant,
              onCheck: (index, isCompleted) {},
              onDelete: (index) {},
              onUpdate: (index, task) {},
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(border: Border.all(color: Colors.white)),
            child: ClearTaskList(
              tasks: tasksNotUrgentUnimportant,
              onCheck: (index, isCompleted) {},
              onDelete: (index) {},
              onUpdate: (index, task) {},
            ),
          ),
        ],
      ),
    );
  }
}
