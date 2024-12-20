import 'package:flutter/material.dart';
import 'package:procrastinator/features/tasks/domain/task.dart';
import 'package:procrastinator/features/tasks/presentation/widgets/task_card.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;
  final Function(int id, bool isCompleted)? onCheck;
  final Function(int id, Task task)? onUpdate;
  final Function(int id)? onDelete;
  const TaskList(
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
        return TaskCard(
          task: tasks[index],
          onUpdate: (Task task) {
            if (onUpdate != null) {
              onUpdate!(tasks[index].id, task);
            }
          },
          onCheck: (isCompleted) {
            if (onCheck != null) {
              onCheck!(tasks[index].id, isCompleted);
            }
          },
          onDelete: () {
            if (onDelete != null) {
              onDelete!(tasks[index].id);
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
