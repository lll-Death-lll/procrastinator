import 'dart:convert';

import 'package:procrastinator/features/tasks/data/repository/parse_task.dart';
import 'package:procrastinator/features/tasks/domain/task.dart';
import 'package:procrastinator/main.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite;

List<Task> getDailyTasks() {
  return getDailyTasksDB(db, 'daily', 'tasks');
}

List<Task> getDailyTasksDB(
    sqlite.Database database, String dailyTable, String taskTable) {
  var dailyIds = getDailyTasksIdsDB(database, dailyTable);
  List<Task> dailies = [];

  for (var id in dailyIds) {
    var result =
        database.select('''SELECT * FROM $taskTable WHERE id = '$id';''');
    if (result.isEmpty) {
      continue;
    }
    Task? task = convertToTask(result[0]);
    if (task != null) {
      dailies.add(task);
    }
  }

  return dailies;
}

Set<int> getDailyTasksIds() {
  return getDailyTasksIdsDB(db, 'daily');
}

Set<int> getDailyTasksIdsDB(sqlite.Database database, String table) {
  var dbDailies = database
      .select('''SELECT * FROM $table WHERE daily_date = DATE('now');''');
  if (dbDailies.isEmpty) {
    return {};
  }
  var jsonSet = dbDailies[0]['tasks'];
  List<dynamic> dynList = jsonDecode(jsonSet);
  return dynList.cast<int>().toSet();
}

void setDailyTasks(Set<int> tasks) {
  return setDailyTasksDB(tasks, db, 'daily');
}

void setDailyTasksDB(Set<int> tasks, sqlite.Database database, String table) {
  var tasksJson = jsonEncode(tasks.toList());

  database.execute('''
        INSERT OR REPLACE INTO $table
        (daily_date, tasks)
        VALUES
        (DATE('now'), '$tasksJson');
        ''');
}
