import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:procrastinator/features/tasks/domain/task_category.dart';
import 'package:procrastinator/features/tasks/domain/task_priority.dart';
import 'package:procrastinator/features/tasks/domain/task_urgency.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class TaskModel {
  final int id;
  final String name;
  final String? description;
  final Category category;
  final Priority priority;
  final Urgency urgency;
  final int? eta;
  final DateTime? completedAt;
  final DateTime createdAt;
  TaskModel(
      {required this.id,
      required this.name,
      this.description,
      required this.category,
      required this.priority,
      required this.urgency,
      this.eta,
      this.completedAt,
      required this.createdAt});

  Map<String, Object?> toJson() => {
        TaskFields.id: id,
        TaskFields.name: name,
        TaskFields.description: description ?? '',
        TaskFields.category: category.toString(),
        TaskFields.priority: priority.toString(),
        TaskFields.urgency: urgency.toString(),
        TaskFields.eta: eta ?? '',
        TaskFields.completedAt: completedAt?.toIso8601String() ?? '',
        TaskFields.createdAt: createdAt.toIso8601String()
      };

  TaskModel copy({
    int? id,
    String? name,
    String? description,
    Category? category,
    Priority? priority,
    Urgency? urgency,
    int? eta,
    DateTime? completedAt,
    DateTime? createdAt,
  }) =>
      TaskModel(
          id: id ?? this.id,
          name: name ?? this.name,
          description: description ?? this.description,
          category: category ?? this.category,
          priority: priority ?? this.priority,
          urgency: urgency ?? this.urgency,
          eta: eta ?? this.eta,
          completedAt: completedAt ?? this.completedAt,
          createdAt: createdAt ?? this.createdAt);

  factory TaskModel.fromJson(Map<String, Object?> json) => TaskModel(
        id: json[TaskFields.id] as int,
        name: json[TaskFields.name] as String,
        description: json[TaskFields.description] as String?,
        category: (json[TaskFields.category] as String).toCategory(),
        priority: (json[TaskFields.priority] as String).toPriority(),
        urgency: (json[TaskFields.urgency] as String).toUrgency(),
        eta: int.tryParse(json[TaskFields.eta] as String),
        completedAt: DateTime.tryParse(
          (json[TaskFields.completedAt] as String? ?? ''),
        ),
        createdAt: DateTime.parse(json[TaskFields.createdAt] as String),
      );
}

class TaskFields {
  static const String tableName = 'tasks';
  static const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const String nameType = 'TEXT NOT NULL';
  static const String descriptionType = 'TEXT';
  static const String categoryType = 'TEXT NOT NULL';
  static const String priorityType = 'TEXT NOT NULL';
  static const String urgencyType = 'TEXT NOT NULL';
  static const String etaType = 'INTEGER';
  static const String completedAtType = 'TEXT';
  static const String createdAtType = 'TEXT NOT NULL';

  static const String id = 'id';
  static const String name = 'name';
  static const String description = 'description';
  static const String category = 'category';
  static const String priority = 'priority';
  static const String urgency = 'urgency';
  static const String eta = 'eta';
  static const String completedAt = 'completed_at';
  static const String createdAt = 'created_at';

  static const List<String> values = [
    id,
    name,
    description,
    category,
    priority,
    urgency,
    eta,
    completedAt,
    createdAt
  ];
}

class DailyModel {
  final int id;
  final DateTime? dailyDate;
  final Set<int> tasks;
  DailyModel({
    required this.id,
    this.dailyDate,
    required this.tasks,
  });

  Map<String, Object?> toJson() => {
        DailyFields.id: id,
        DailyFields.dailyDate: dailyDate?.toIso8601String() ?? "DATE('now')",
        DailyFields.tasks: jsonEncode(tasks),
      };

  DailyModel copy({
    int? id,
    DateTime? dailyDate,
    Set<int>? tasks,
  }) =>
      DailyModel(
          id: id ?? this.id,
          dailyDate: dailyDate ?? this.dailyDate,
          tasks: tasks ?? this.tasks);

  factory DailyModel.fromJson(Map<String, Object?> json) => DailyModel(
        id: json[DailyFields.id] as int,
        dailyDate: DateTime.parse([DailyFields.dailyDate] as String),
        tasks: jsonDecode(json[DailyFields.tasks] as String? ?? "{}"),
      );
}

class DailyFields {
  static const String tableName = 'daily';
  static const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const String dailyDateType = 'TEXT NOT NULL';
  static const String tasksType = 'TEXT';

  static const String id = 'id';
  static const String dailyDate = 'daily_date';
  static const String tasks = 'tasks';

  static const List<String> values = [id, dailyDate, tasks];
}

class TaskDatabase {
  static final TaskDatabase instance = TaskDatabase._internal();

  static Database? _database;

  TaskDatabase._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    if (Platform.isWindows || Platform.isLinux) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }
    var dbPath = await getDatabasesPath();
    if (!await Directory.fromUri(Uri.directory(dbPath)).exists()) {
      await Directory(dbPath).create(recursive: true);
    }
    String path = join(dbPath, 'tasks.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, _) async {
    return await db.execute('''
        CREATE TABLE IF NOT EXISTS ${TaskFields.tableName} (
          ${TaskFields.id} ${TaskFields.idType},
          ${TaskFields.name} ${TaskFields.nameType},
          ${TaskFields.description} ${TaskFields.descriptionType},
          ${TaskFields.category} ${TaskFields.categoryType},
          ${TaskFields.priority} ${TaskFields.priorityType},
          ${TaskFields.urgency} ${TaskFields.urgencyType},
          ${TaskFields.eta} ${TaskFields.etaType},
          ${TaskFields.completedAt} ${TaskFields.completedAtType},
          ${TaskFields.createdAt} ${TaskFields.createdAtType}
        );

        CREATE TABLE IF NOT EXISTS ${DailyFields.tableName} (
          ${DailyFields.id} ${DailyFields.idType},
          ${DailyFields.dailyDate} ${DailyFields.dailyDateType},
          ${DailyFields.tasks} ${DailyFields.tasksType}
        );
      ''');
  }

  Future<void> resetDatabase() async {
    final db = await instance.database;

    await db.execute('''
      DROP TABLE IF EXISTS ${TaskFields.tableName};
      DROP TABLE IF EXISTS ${DailyFields.tableName};
    ''');

    return _createDatabase(db, 0);
  }

  Future<TaskModel> create(TaskModel task) async {
    final db = await instance.database;
    var taskJson = task.toJson();
    taskJson.remove('id');
    final id = await db.insert(TaskFields.tableName, taskJson);
    return task.copy(id: id);
  }

  Future<TaskModel?> read(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      TaskFields.tableName,
      columns: TaskFields.values,
      where: '${TaskFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return TaskModel.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<List<TaskModel>> readAll() async {
    final db = await instance.database;
    const orderBy = '${TaskFields.createdAt} DESC';
    final result = await db.query(TaskFields.tableName, orderBy: orderBy);
    return result.map((json) => TaskModel.fromJson(json)).toList();
  }

  Future<int> update(TaskModel task) async {
    final db = await instance.database;
    return db.update(
      TaskFields.tableName,
      task.toJson(),
      where: '${TaskFields.id} = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      TaskFields.tableName,
      where: '${TaskFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> complete(int id) async {
    final db = await instance.database;
    return await db.update(
      TaskFields.tableName,
      {'completed_at': "DATE('now')"},
      where: '${TaskFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> uncomplete(int id) async {
    final db = await instance.database;
    return await db.update(
      TaskFields.tableName,
      {'completed_at': ''},
      where: '${TaskFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<List<TaskModel>> readDailyTasks() async {
    DailyModel? model = await readDaily();
    if (model == null) {
      return [];
    }

    List<TaskModel> dailies = [];
    for (var id in model.tasks) {
      TaskModel? task = await read(id);
      if (task != null) {
        dailies.add(task);
      }
    }

    return dailies;
  }

  Future<DailyModel> createDaily(DailyModel daily) async {
    final db = await instance.database;
    final id = await db.insert(DailyFields.tableName, daily.toJson());
    return daily.copy(id: id);
  }

  Future<DailyModel?> readDaily() async {
    final db = await instance.database;
    final maps = await db.query(
      DailyFields.tableName,
      columns: DailyFields.values,
      where: "${DailyFields.dailyDate} = DATE('now')",
    );

    if (maps.isNotEmpty) {
      return DailyModel.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<int> updateDaily(DailyModel daily) async {
    final db = await instance.database;
    return db.update(
      DailyFields.tableName,
      daily.toJson(),
      where: '${DailyFields.id} = ?',
      whereArgs: [daily.id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
