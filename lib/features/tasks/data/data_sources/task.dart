import 'package:procrastinator/features/tasks/data/repository/parse_task.dart';
import 'package:procrastinator/features/tasks/domain/task.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite;

import '../../../../main.dart';

int getNewId() {
  return getNewIdDB(db, 'tasks');
}

int getNewIdDB(sqlite.Database database, String table) {
  var newID = database.select('''
    SELECT COUNT(*) FROM $table;
  ''')[0]['COUNT(*)'].toString();

  return int.tryParse(newID) ?? 0;
}

void saveTask(Task task) {
  saveTaskDB(db, 'tasks', task);
}

void saveTaskDB(sqlite.Database database, String table, Task task) {
  var taskDescription =
      task.description != null ? '\'${task.description}\'' : 'null';
  var taskETA = task.eta != null ? '\'${task.eta}\'' : 'null';
  var completedAt =
      task.completedAt != null ? '\'${task.completedAt}\'' : 'null';
  database.execute('''
        INSERT INTO $table
        (name, description,
        category, priority,
        urgency, eta,
        completed_at, created_at)
        VALUES
        ('${task.name}', $taskDescription,
        '${task.category}', '${task.priority}',
        '${task.urgency}', $taskETA,
        $completedAt, '${task.createdAt}');
        ''');
}

void updateTask(Task task) {
  updateTaskDB(db, 'tasks', task);
}

void updateTaskDB(sqlite.Database database, String table, Task task) {
  var taskDescription =
      task.description != null ? '\'${task.description}\'' : 'null';
  var taskETA = task.eta != null ? '\'${task.eta}\'' : 'null';
  database.execute('''
    UPDATE $table
    SET description = $taskDescription,
    category = '${task.category}',
    priority = '${task.priority}',
    urgency = '${task.urgency}',
    eta = $taskETA
    WHERE id = ${task.id};
  ''');
}

void completeTask(int taskID) {
  completeTaskDB(db, 'tasks', taskID);
}

void completeTaskDB(sqlite.Database database, String table, int taskId) {
  database.execute('''
    UPDATE $table
    SET completed_at = datetime('now')
    WHERE id = $taskId;
  ''');
}

void removeTaskCompletion(int taskID) {
  removeTaskCompletionDB(db, 'tasks', taskID);
}

void removeTaskCompletionDB(
    sqlite.Database database, String table, int taskId) {
  database.execute('''
    UPDATE $table
    SET completed_at = null
    WHERE id = $taskId;
  ''');
}

List<Task> getAllTasks() {
  return getAllTasksDB(db, 'tasks');
}

List<Task> getAllTasksDB(sqlite.Database database, String table) {
  List<Task> tasks = [];

  var dbTasks = database.select('''SELECT * FROM $table''');

  dbTasks.forEach(((dbTask) {
    Task? task = convertToTask(dbTask);
    if (task != null) {
      tasks.add(task);
    }
  }));

  return tasks;
}
