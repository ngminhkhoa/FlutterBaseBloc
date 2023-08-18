import 'package:sqflite/sqflite.dart';

import '../data/task_database.dart';
import '../models/task_entity.dart';

class TaskRepository {
  final TaskDatabase _taskDatabase = TaskDatabase.instance;

  Future<void> insertTask(TaskEntity taskEntity) async {
    final db = await _taskDatabase.database;
    await db.insert(
      'tasks',
      taskEntity.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<TaskEntity>> getTasks() async {
    final db = await _taskDatabase.database;
    final tasksData = await db.query('tasks');
    return tasksData.map((data) => TaskEntity.fromMap(data)).toList();
  }

  Future<void> updateTask(TaskEntity taskEntity) async {
    final db = await _taskDatabase.database;
    await db.update('tasks', taskEntity.toMap(),
        where: 'id = ?', whereArgs: [taskEntity.id]);
  }

  Future<void> deleteTask(int id) async {
    final db = await _taskDatabase.database;
    await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
