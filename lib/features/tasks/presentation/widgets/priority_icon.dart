import 'package:flutter/material.dart';
import 'package:procrastinator/features/tasks/domain/task.dart';
import 'package:procrastinator/features/tasks/domain/task_priority.dart';

class PriorityIcon extends StatelessWidget {
  const PriorityIcon({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Icon(
      task.priority.icon,
      color: Colors.white,
    );
  }
}

extension PriorityToIcon on Priority {
  IconData get icon {
    switch (this) {
      case Priority.high:
        return Icons.star;
      case Priority.medium:
        return Icons.star_half;
      case Priority.low:
        return Icons.star_border;
    }
  }
}
