import 'package:flutter/material.dart';
import 'package:procrastinator/features/tasks/presentation/pages/home.dart';
import 'package:sqlite3/sqlite3.dart';

final db = setupApp();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Procrastinator',
      routes: {
        '/': (context) => const Home(),
        '/martix': (context) => Container(),
        '/daily': (context) => Container(),
      },
    );
  }
}

Database setupApp() {
  final db = sqlite3.openInMemory();

  db.execute('''
    CREATE TABLE IF NOT EXISTS tasks (
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
