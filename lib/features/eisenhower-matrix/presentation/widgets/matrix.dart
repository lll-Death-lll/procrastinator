import 'dart:math';

import 'package:flutter/material.dart';
import 'package:procrastinator/features/eisenhower-matrix/presentation/widgets/clear_task_list.dart';
import 'package:procrastinator/features/tasks/domain/task.dart';

class Matrix extends StatelessWidget {
  final List<Task> tasksUrgentImportant;
  final List<Task> tasksNotUrgentImportant;
  final List<Task> tasksUrgentUnimportant;
  final List<Task> tasksNotUrgentUnimportant;

  final Function(int taskId, bool isCompleted)? onCheck;
  final Function(int taskId, Task task)? onUpdate;
  final Function(int taskId)? onDelete;

  const Matrix(
      {super.key,
      required this.tasksUrgentImportant,
      required this.tasksNotUrgentImportant,
      required this.tasksUrgentUnimportant,
      required this.tasksNotUrgentUnimportant,
      this.onCheck,
      this.onUpdate,
      this.onDelete});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      var maxSize = min(constraints.maxHeight, constraints.maxWidth);
      var entries = [
        {
          "title": "Urgent & Important",
          "tasks": tasksUrgentImportant,
        },
        {
          "title": "Not Urgent & Important",
          "tasks": tasksNotUrgentImportant,
        },
        {
          "title": "Urgent & Unimportant",
          "tasks": tasksUrgentUnimportant,
        },
        {
          "title": "Not Urgent & Unimportant",
          "tasks": tasksNotUrgentUnimportant,
        },
      ];

      int maxTextWidth = entries
          .map((e) => e["title"].toString().length)
          .reduce((a, b) => max(a, b));

      return SizedBox(
        height: maxSize,
        width: maxSize,
        child: GridView.count(
          crossAxisCount: 2,
          primary: false,
          padding: EdgeInsets.all(16),
          shrinkWrap: false,
          children: [
            for (var entry in entries)
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                ),
                child: Column(
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        (entry["title"] as String).padRight(
                            maxTextWidth - entry["title"].toString().length),
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    Expanded(
                      child: ClearTaskList(
                        tasks: entry["tasks"]
                            as List<Task>, // Adjust type as needed
                        onCheck: (id, isCompleted) {},
                        onDelete: (id) {},
                        onUpdate: (id, task) {},
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      );
    });
  }
}
