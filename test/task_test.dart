import 'package:procrastinator/features/tasks/data/data_sources/task.dart';
import 'package:procrastinator/features/tasks/domain/task.dart';
import 'package:procrastinator/features/tasks/domain/task_category.dart';
import 'package:procrastinator/features/tasks/domain/task_priority.dart';
import 'package:procrastinator/features/tasks/domain/task_urgency.dart';
import 'package:test/test.dart';

import 'setup.dart';

void main() {
  group('Test task db interaction', () {
    test('Task is parsed correctly', () {
      String tableName = 'test_parse';
      var db = setupTestApp(tableName);

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
      saveTaskDB(db, tableName, manualTask);

      Task databaseTask = getAllTasksDB(db, tableName)[0];

      // Assert
      assert(manualTask.id == databaseTask.id);
      assert(manualTask.name == databaseTask.name);
      assert(manualTask.eta == databaseTask.eta);
      assert(manualTask.description == databaseTask.description);
      assert(manualTask.category == databaseTask.category);
      assert(manualTask.priority == databaseTask.priority);
      assert(manualTask.urgency == databaseTask.urgency);
      assert(manualTask.createdAt == databaseTask.createdAt);

      cleanupTestApp(db, tableName);
    });

    test('Task is completed successfully', () {
      String tableName = 'test_complete';
      var db = setupTestApp(tableName);

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
      saveTaskDB(db, tableName, manualTask);

      completeTask(manualTask.id);
      manualTask.completedAt = DateTime.now();

      Task databaseTask = getAllTasksDB(db, tableName)[0];

      // Assert
      assert(manualTask.completedAt != null &&
          manualTask.completedAt!.compareTo(databaseTask.completedAt!) >= 0);

      cleanupTestApp(db, tableName);
    });
  });

  test('Task is updated successfully', () {
    String tableName = 'test_update';
    var db = setupTestApp(tableName);

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
    saveTaskDB(db, tableName, manualTask);

    completeTask(manualTask.id);
    manualTask.completedAt = DateTime.now();

    Task databaseTask = getAllTasksDB(db, tableName)[0];

    // Assert
    assert(manualTask.completedAt != null &&
        manualTask.completedAt!.compareTo(databaseTask.completedAt!) >= 0);

    cleanupTestApp(db, tableName);
  });
}
