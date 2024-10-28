import 'package:procrastinator/features/tasks/domain/task_category.dart';
import 'package:procrastinator/features/tasks/domain/task_priority.dart';
import 'package:procrastinator/features/tasks/domain/task_urgency.dart';

class Task {
  int id;
  String name;
  String? description;
  Category category;
  Priority priority;
  Urgency urgency;
  int? eta;
  DateTime? completedAt;
  DateTime createdAt;

  Task(
      {required this.id,
      required this.name,
      this.description,
      required this.category,
      required this.priority,
      required this.urgency,
      this.eta,
      this.completedAt,
      required this.createdAt});
}
