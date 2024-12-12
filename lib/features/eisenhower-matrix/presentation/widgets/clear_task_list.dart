import 'package:flutter/material.dart';
import 'package:procrastinator/features/eisenhower-matrix/presentation/widgets/clear_task_card.dart';
import 'package:procrastinator/features/tasks/domain/task.dart';
import 'package:procrastinator/features/tasks/presentation/widgets/task_card.dart';

class ClearTaskList extends StatelessWidget {
  final List<Task> tasks;
  final Function(int index, bool isCompleted)? onCheck;
  final Function(int index, Task task)? onUpdate;
  final Function(int index)? onDelete;
  const ClearTaskList(
      {super.key,
      required this.tasks,
      this.onCheck,
      this.onUpdate,
      this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: tasks.length,
      itemBuilder: (BuildContext context, int index) {
        return ClearTaskCard(
          task: tasks[index],
          onUpdate: (Task task) {
            if (onUpdate != null) {
              onUpdate!(index, task);
            }
          },
          onCheck: (isCompleted) {
            if (onCheck != null) {
              onCheck!(index, isCompleted);
            }
          },
          onDelete: () {
            if (onDelete != null) {
              onDelete!(index);
            }
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) => Divider(
        color: Colors.grey[600],
      ),
    );
  }
}