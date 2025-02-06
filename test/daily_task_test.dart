import 'package:procrastinator/features/daily-tasks/domain/daily_tasks.dart';
import 'package:procrastinator/features/tasks/data/data_sources/task.dart';
import 'package:procrastinator/features/tasks/domain/task.dart';
import 'package:procrastinator/features/tasks/domain/task_category.dart';
import 'package:procrastinator/features/tasks/domain/task_priority.dart';
import 'package:procrastinator/features/tasks/domain/task_urgency.dart';
import 'package:test/test.dart';

import 'setup.dart';

void main() {
  group('Test daily tasks db interaction', () {
    test('Dailies are parsed correctly', () async {
      var db = await setupTestApp();

      // Arrange
      String name = "Task name";
      String? description;
      Category category = Category.other;
      Priority priority = Priority.medium;
      Urgency urgency = Urgency.medium;
      DateTime createdAt = DateTime.now();
      int? eta = 5;

      Task manualTask = Task(
          id: 1,
          name: name,
          category: category,
          description: description,
          priority: priority,
          urgency: urgency,
          createdAt: createdAt,
          eta: eta);

      Set<int> manualDailies = {manualTask.id};

      // Act
      saveTaskDB(db, manualTask);

      Task databaseTask = await getAllTasksDB(db).then((tasks) => tasks.first);

      await setDailyTasksDB(db, {databaseTask.id});

      Set<int> dailies = await getDailyTasksDBIds(db);

      // Assert
      assert(dailies.containsAll(manualDailies) &&
          manualDailies.containsAll(dailies));
    });

    test('Dailies are updated successfully', () async {
      var db = await setupTestApp();

      // Arrange
      String name = "Task name";
      String? description;
      Category category = Category.other;
      Priority priority = Priority.medium;
      Urgency urgency = Urgency.medium;
      DateTime createdAt = DateTime.now();
      int? eta = 5;

      Task manualTask1 = Task(
          id: 1,
          name: name,
          category: category,
          description: description,
          priority: priority,
          urgency: urgency,
          createdAt: createdAt,
          eta: eta);

      Task manualTask2 = Task(
          id: 2,
          name: name,
          category: category,
          description: description,
          priority: priority,
          urgency: urgency,
          createdAt: createdAt,
          eta: eta);

      Task manualTask3 = Task(
          id: 3,
          name: name,
          category: category,
          description: description,
          priority: priority,
          urgency: urgency,
          createdAt: createdAt,
          eta: eta);

      Task manualTask4 = Task(
          id: 4,
          name: name,
          category: category,
          description: description,
          priority: priority,
          urgency: urgency,
          createdAt: createdAt,
          eta: eta);

      Set<int> manualDailies = {manualTask1.id};
      Set<int> manualDailiesAfter = {
        manualTask1.id,
        manualTask2.id,
        manualTask4.id
      };

      // Act
      await saveTaskDB(db, manualTask1);
      await saveTaskDB(db, manualTask2);

      Task databaseTask = await getAllTasksDB(db).then((tasks) => tasks.first);

      await setDailyTasksDB(db, {databaseTask.id});

      Set<int> dailies = await getDailyTasksDBIds(db);

      // Assert
      assert(dailies.containsAll(manualDailies) &&
          manualDailies.containsAll(dailies));

      // Act
      await saveTaskDB(db, manualTask3);
      await saveTaskDB(db, manualTask4);

      List<Task> databaseTasks = await getAllTasksDB(db);
      await setDailyTasksDB(
          db, {databaseTasks[0].id, databaseTasks[1].id, databaseTasks[3].id});

      Set<int> dailiesAfter = await getDailyTasksDBIds(db);

      // Assert
      assert(dailiesAfter.containsAll(manualDailiesAfter) &&
          manualDailiesAfter.containsAll(dailiesAfter));
    });
  });
}
