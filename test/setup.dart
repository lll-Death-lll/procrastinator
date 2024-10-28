import 'package:sqlite3/sqlite3.dart';

Database setupTestApp(String tableName) {
  final db = sqlite3.openInMemory();

  db.execute('''
    CREATE TABLE IF NOT EXISTS '$tableName' (
      id INTEGER NOT NULL PRIMARY KEY,
      name TEXT NOT NULL,
      description TEXT,
      category TEXT NOT NULL,
      priority TEXT NOT NULL,
      urgency TEXT NOT NULL,
      eta INTEGER,
      completed_at TEXT,
      created_at TEXT NOT NULL
    );
  ''');

  return db;
}

void cleanupTestApp(Database db, String dbName) {
  db.execute('''
    DROP TABLE IF EXISTS $dbName;
  ''');
}
