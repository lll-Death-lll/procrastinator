import 'package:flutter/material.dart';
import 'package:procrastinator/features/daily-tasks/presentation/pages/daily_tasks.dart';
import 'package:procrastinator/features/eisenhower-matrix/presentation/pages/eisenhower_matrix.dart';
import 'package:procrastinator/features/tasks/data/repository/database.dart';
import 'package:procrastinator/features/tasks/presentation/pages/home.dart';

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
        '/': (context) => const SafeArea(
              child: Home(),
            ),
        '/matrix': (context) => const SafeArea(
              child: EisenhowerMatrix(),
            ),
        '/daily': (context) => const SafeArea(child: DailyTasks()),
      },
    );
  }
}

TaskDatabase setupApp() {
  var db = TaskDatabase.instance;
  return db;
}
