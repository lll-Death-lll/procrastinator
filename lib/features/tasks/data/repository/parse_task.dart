import 'package:procrastinator/features/tasks/domain/task.dart';
import 'package:procrastinator/features/tasks/domain/task_category.dart';
import 'package:procrastinator/features/tasks/domain/task_priority.dart';
import 'package:procrastinator/features/tasks/domain/task_urgency.dart';
import 'package:sqlite3/sqlite3.dart';

Task? convertToTask(Row dbTask) {
  int id;
  String name;
  String? description;
  Category category;
  Priority priority;
  Urgency urgency;
  int? eta;
  DateTime? completedAt;
  DateTime createdAt;

  try {
    id = dbTask['id'];
    name = dbTask['name'];
    if (dbTask['description'] == 'null') {
      description = null;
    } else {
      description = dbTask['description'];
    }
    if (dbTask['eta'] == 'null') {
      eta = null;
    } else {
      eta = int.tryParse(dbTask['eta'].toString());
    }
    category = dbTask['category'].toString().toCategory();
    priority = dbTask['priority'].toString().toPriority();
    urgency = dbTask['urgency'].toString().toUrgency();
    completedAt = DateTime.tryParse(dbTask['completed_at'].toString());
    createdAt = DateTime.parse(dbTask['created_at'].toString());
  } catch (e) {
    return null;
  }

  Task task = Task(
      id: id,
      name: name,
      description: description,
      category: category,
      priority: priority,
      urgency: urgency,
      eta: eta,
      completedAt: completedAt,
      createdAt: createdAt);

  return task;
}
