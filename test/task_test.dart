import 'package:procrastinator/features/tasks/data/data_sources/task.dart';
import 'package:procrastinator/features/tasks/domain/task.dart';
import 'package:procrastinator/features/tasks/domain/task_category.dart';
import 'package:procrastinator/features/tasks/domain/task_priority.dart';
import 'package:procrastinator/features/tasks/domain/task_urgency.dart';
import 'package:test/test.dart';

import 'setup.dart';

void main() {
  group('Test task db interaction', () {
    test('Task is parsed correctly', () async {
      var db = await setupTestApp();

      // Arrange
      int id = 1;
      String name = "Task name";
      String? description;
      Category category = Category.other;
      Priority priority = Priority.medium;
      Urgency urgency = Urgency.medium;
      DateTime createdAt = DateTime.now();
      int? eta = 5;

      Task manualTask = Task(
          id: id,
          name: name,
          category: category,
          description: description,
          priority: priority,
          urgency: urgency,
          createdAt: createdAt,
          eta: eta);

      // Act
      await saveTaskDB(db, manualTask);

      Task databaseTask = await getAllTasksDB(db).then((tasks) => tasks.first);

      // Assert
      assert(manualTask.id == databaseTask.id);
      assert(manualTask.name == databaseTask.name);
      assert(manualTask.eta == databaseTask.eta);
      assert(manualTask.description == databaseTask.description);
      assert(manualTask.category == databaseTask.category);
      assert(manualTask.priority == databaseTask.priority);
      assert(manualTask.urgency == databaseTask.urgency);
      assert(manualTask.createdAt == databaseTask.createdAt);
    });

    test('Task is completed successfully', () async {
      var db = await setupTestApp();

      // Arrange
      int id = 1;
      String name = "Task name";
      Category category = Category.other;
      Priority priority = Priority.medium;
      Urgency urgency = Urgency.medium;
      DateTime createdAt = DateTime.now();
      DateTime completedAt = DateTime.now();
      int? eta = 5;

      Task manualTask = Task(
          id: id,
          name: name,
          category: category,
          priority: priority,
          urgency: urgency,
          createdAt: createdAt,
          completedAt: completedAt,
          eta: eta);

      // Act
      await saveTaskDB(db, manualTask);

      await completeTaskDB(db, manualTask.id);
      manualTask.completedAt = DateTime.now();

      Task databaseTaskCompleted =
          await getAllTasksDB(db).then((tasks) => tasks.first);

      // Assert
      assert(databaseTaskCompleted.completedAt != null &&
          manualTask.completedAt!
                  .compareTo(databaseTaskCompleted.completedAt!) >=
              0);

      // Act
      await removeTaskCompletionDB(db, manualTask.id);
      Task databaseTaskUncompleted =
          await getAllTasksDB(db).then((tasks) => tasks.first);

      // Assert
      assert(databaseTaskUncompleted.completedAt == null);
    });
  });

  test('Task is updated successfully', () async {
    var db = await setupTestApp();

    // Arrange
    int id = 1;
    String name = "Task name";
    Category category = Category.other;
    Priority priority = Priority.medium;
    Urgency urgency = Urgency.medium;
    DateTime createdAt = DateTime.now();
    DateTime completedAt = DateTime.now();
    int? eta = 5;

    Task manualTask = Task(
        id: id,
        name: name,
        category: category,
        priority: priority,
        urgency: urgency,
        createdAt: createdAt,
        completedAt: completedAt,
        eta: eta);

    // Act
    await saveTaskDB(db, manualTask);

    await completeTask(manualTask.id);
    manualTask.completedAt = DateTime.now();

    Task databaseTask = await getAllTasksDB(db).then((tasks) => tasks.first);

    // Assert
    assert(manualTask.completedAt != null &&
        manualTask.completedAt!.compareTo(databaseTask.completedAt!) >= 0);
  });

  test('Task is completed successfully', () async {
    var db = await setupTestApp();

    // Arrange
    int id = 1;
    String name = "Task name";
    Category category = Category.other;
    Priority priority = Priority.medium;
    Urgency urgency = Urgency.medium;
    DateTime createdAt = DateTime.now();
    DateTime completedAt = DateTime.now();
    int? eta = 5;

    Task manualTask = Task(
        id: id,
        name: name,
        category: category,
        priority: priority,
        urgency: urgency,
        createdAt: createdAt,
        completedAt: completedAt,
        eta: eta);

    // Act
    await saveTaskDB(db, manualTask);

    await completeTask(manualTask.id);
    manualTask.completedAt = DateTime.now();

    Task databaseTask = await getAllTasksDB(db).then((tasks) => tasks.first);

    // Assert
    assert(manualTask.completedAt != null &&
        manualTask.completedAt!.compareTo(databaseTask.completedAt!) >= 0);
  });
}
