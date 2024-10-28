import 'package:flutter/material.dart';
import 'package:procrastinator/features/tasks/domain/task.dart';
import 'package:procrastinator/features/tasks/domain/task_urgency.dart';

class UrgencyIcon extends StatelessWidget {
  const UrgencyIcon({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Icon(
      task.urgency.icon,
      color: Colors.white,
    );
  }
}

extension UrgencyToIcon on Urgency {
  IconData get icon {
    switch (this) {
      case Urgency.high:
        return Icons.hourglass_empty;
      case Urgency.medium:
        return Icons.hourglass_bottom;
      case Urgency.low:
        return Icons.hourglass_full;
    }
  }
}
