import 'package:procrastinator/features/tasks/data/repository/database.dart';
import 'package:procrastinator/features/tasks/domain/task.dart';
import 'package:procrastinator/main.dart';

Future<void> saveTask(Task task) {
  return saveTaskDB(db, task);
}

Future<void> saveTaskDB(TaskDatabase database, Task task) {
  return database.create(intoTaskModel(task));
}

Future<void> removeTask(Task task) {
  return removeTaskDB(db, task);
}

Future<void> removeTaskDB(TaskDatabase database, Task task) {
  return database.delete(task.id);
}

Future<void> updateTask(Task task) {
  return updateTaskDB(db, 'tasks', task);
}

Future<void> updateTaskDB(TaskDatabase database, String table, Task task) {
  return database.update(intoTaskModel(task));
}

Future<void> completeTask(int taskID) {
  return completeTaskDB(db, taskID);
}

Future<void> completeTaskDB(TaskDatabase database, int taskId) {
  return database.complete(taskId);
}

Future<void> removeTaskCompletion(int taskID) {
  return removeTaskCompletionDB(db, taskID);
}

Future<void> removeTaskCompletionDB(TaskDatabase database, int taskId) {
  return database.uncomplete(taskId);
}

Future<List<Task>> getAllTasks() {
  return getAllTasksDB(db);
}

Future<List<Task>> getAllTasksDB(TaskDatabase database) {
  return database.readAll().then((m) => m.map(fromTaskModel).toList());
}

Task fromTaskModel(TaskModel model) {
  return Task(
      id: model.id,
      name: model.name,
      description: model.description,
      category: model.category,
      priority: model.priority,
      urgency: model.urgency,
      eta: model.eta,
      completedAt: model.completedAt,
      createdAt: model.createdAt);
}

TaskModel intoTaskModel(Task task) {
  return TaskModel(
      id: task.id,
      name: task.name,
      description: task.description,
      category: task.category,
      priority: task.priority,
      urgency: task.urgency,
      eta: task.eta,
      completedAt: task.completedAt,
      createdAt: task.createdAt);
}
