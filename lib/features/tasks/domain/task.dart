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

extension Sorting on List<Task> {
  sortById() {
    sort((a, b) => a.id.compareTo(b.id));
  }

  sortByName() {
    sort((a, b) => a.name.compareTo(b.name));
  }

  sortByCategory() {
    sort((a, b) => a.category.compareTo(b.category));
  }

  sortByPriority() {
    sort((a, b) => a.priority.compareTo(b.priority));
  }

  sortByUrgency() {
    sort((a, b) => a.urgency.compareTo(b.urgency));
  }

  sortByETA() {
    sort((a, b) => (a.eta ?? -1).compareTo((b.eta ?? -1)));
  }

  sortByCompletedAt() {
    sort((a, b) => (a.completedAt ?? DateTime.fromMicrosecondsSinceEpoch(0))
        .compareTo((b.completedAt ?? DateTime.fromMicrosecondsSinceEpoch(0))));
  }

  sortByCreatedAt() {
    sort((a, b) => a.createdAt.compareTo(b.createdAt));
  }

  sortByIdReverse() {
    sort((b, a) => a.id.compareTo(b.id));
  }

  sortByNameReverse() {
    sort((b, a) => a.name.compareTo(b.name));
  }

  sortByCategoryReverse() {
    sort((b, a) => a.category.compareTo(b.category));
  }

  sortByPriorityReverse() {
    sort((b, a) => a.priority.compareTo(b.priority));
  }

  sortByUrgencyReverse() {
    sort((b, a) => a.urgency.compareTo(b.urgency));
  }

  sortByETAReverse() {
    sort((b, a) => (a.eta ?? -1).compareTo((b.eta ?? -1)));
  }

  sortByCompletedAtReverse() {
    sort((b, a) => (a.completedAt ?? DateTime.fromMicrosecondsSinceEpoch(0))
        .compareTo((b.completedAt ?? DateTime.fromMicrosecondsSinceEpoch(0))));
  }

  sortByCreatedAtReverse() {
    sort((b, a) => a.createdAt.compareTo(b.createdAt));
  }
}
