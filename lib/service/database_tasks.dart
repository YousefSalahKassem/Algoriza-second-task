import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoalgoriza/model/task_model.dart';
import '../styles/strings.dart';

class DatabaseTasks {
  DatabaseTasks._();

  static final DatabaseTasks db = DatabaseTasks._();
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDatabase();
    return _database;
  }

  initDatabase() async {
    debugPrint('AppDatabaseInitialized');

    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, 'task.db');
    return await openDatabase(path,
        version: 1, onCreate: _onCreate, onOpen: onOpen);
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $allTasks (
        id INTEGER PRIMARY KEY,
        $columnTitle TEXT NOT NULL,
        $columnStart TEXT NOT NULL,
        $columnEnd TEXT NOT NULL,
        $columnReminder TEXT NOT NULL,
        $columnRepeat TEXT NOT NULL,
        $columnStatus TEXT NOT NULL,
        $columnDate TEXT NOT NULL,
        $columnFavourite TEXT NOT NULL
      )
    ''');
  }

  onOpen(Database db) async {
    _database = db;
  }

  insertTask(TaskModel task) async {
    final db = await database;
    await db!.insert(allTasks, task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    debugPrint('User Data Inserted');
  }

  Future<List<TaskModel>> getTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.query(allTasks);
    return List.generate(maps.length, (i) {
      return TaskModel(
          title: maps[i][columnTitle],
          start: maps[i][columnStart],
          end: maps[i][columnEnd],
          reminder: maps[i][columnReminder],
          repeat: maps[i][columnRepeat],
          date: maps[i][columnDate],
          status: maps[i][columnStatus],
          favourite: maps[i][columnFavourite]);
    });
  }

  deleteTask(String title) async {
    final db = await database;
    await db!.delete(allTasks, where: '$columnTitle = ?', whereArgs: [title]);
  }

  updateTask(TaskModel task) async {
    final db = await database;
    await db!.update(allTasks, task.toMap(),
        where: '$columnTitle = ?', whereArgs: [task.title]);
  }
}
