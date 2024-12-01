import 'package:procrastinator/features/tasks/domain/task_category.dart';
import 'package:procrastinator/features/tasks/domain/task_priority.dart';
import 'package:procrastinator/features/tasks/domain/task_urgency.dart';
import 'package:sqflite/sqflite.dart';

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
        TaskFields.description: description,
        TaskFields.category: category.toString(),
        TaskFields.priority: priority.toString(),
        TaskFields.urgency: urgency.toString(),
        TaskFields.eta: eta.toString(),
        TaskFields.completedAt: completedAt?.toIso8601String(),
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
        category: Category.values.firstWhere(
            (e) => e.toString() == json[TaskFields.category] as String),
        priority: Priority.values.firstWhere(
            (e) => e.toString() == json[TaskFields.priority] as String),
        urgency: Urgency.values.firstWhere(
            (e) => e.toString() == json[TaskFields.urgency] as String),
        eta: int.tryParse(json[TaskFields.eta] as String? ?? ''),
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
    final databasePath = await getDatabasesPath();
    final path = '$databasePath/notes.db';
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, _) async {
    return await db.execute('''
        CREATE TABLE ${TaskFields.tableName} (
          ${TaskFields.id} ${TaskFields.idType},
          ${TaskFields.name} ${TaskFields.nameType},
          ${TaskFields.description} ${TaskFields.descriptionType},
          ${TaskFields.category} ${TaskFields.categoryType},
          ${TaskFields.priority} ${TaskFields.priorityType},
          ${TaskFields.urgency} ${TaskFields.urgencyType},
          ${TaskFields.eta} ${TaskFields.etaType},
          ${TaskFields.completedAt} ${TaskFields.completedAtType},
          ${TaskFields.createdAt} ${TaskFields.createdAtType},
        )
      ''');
  }

  Future<TaskModel> create(TaskModel note) async {
    final db = await instance.database;
    final id = await db.insert(TaskFields.tableName, note.toJson());
    return note.copy(id: id);
  }

  Future<TaskModel> read(int id) async {
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
      throw Exception('ID $id not found');
    }
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      TaskFields.tableName,
      where: '${TaskFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
