import 'package:procrastinator/features/tasks/data/data_sources/task.dart';
import 'package:procrastinator/features/tasks/data/repository/database.dart';
import 'package:procrastinator/features/tasks/domain/task.dart';
import 'package:procrastinator/main.dart';

Future<List<Task>> getDailyTasks() {
  return getDailyTasksDB(db);
}

Future<List<Task>> getDailyTasksDB(TaskDatabase database) {
  return db.readDailyTasks().then((m) => m.map(fromTaskModel).toList());
}

Future<Set<int>> getDailyTasksIds() {
  return getDailyTasksDBIds(db);
}

Future<Set<int>> getDailyTasksDBIds(TaskDatabase database) {
  return db.readDaily().then((v) => v?.tasks ?? {});
}

Future<void> setDailyTasks(Set<int> tasks) {
  return setDailyTasksDB(db, tasks);
}

Future<void> setDailyTasksDB(TaskDatabase database, Set<int> tasks) async {
  DailyModel? daily = await database.readDaily();

  if (daily == null) {
    database.createDaily(DailyModel(id: 0, tasks: tasks));
    return;
  }

  database.updateDaily(daily.copy(tasks: tasks));
}
