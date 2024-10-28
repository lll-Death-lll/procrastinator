import 'package:flutter/material.dart';
import 'package:procrastinator/features/tasks/domain/task.dart';
import 'package:procrastinator/features/tasks/domain/task_category.dart';

class CategoryIcon extends StatelessWidget {
  const CategoryIcon({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Icon(
      task.category.icon,
      color: Colors.white,
    );
  }
}

extension CategoryToIcon on Category {
  IconData get icon {
    switch (this) {
      case Category.home:
        return Icons.home;
      case Category.work:
        return Icons.work;
      case Category.learning:
        return Icons.school;
      case Category.other:
        return Icons.category;
    }
  }
}
