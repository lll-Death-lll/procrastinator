import 'package:procrastinator/features/tasks/data/repository/database.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void sqfliteTestInit() {
  // Initialize ffi implementation
  sqfliteFfiInit();
  // Set global factory
  databaseFactory = databaseFactoryFfi;
}

Future<TaskDatabase> setupTestApp() async {
  sqfliteTestInit();

  final TaskDatabase db = TaskDatabase.instance;
  await db.resetDatabase();
  return db;
}
