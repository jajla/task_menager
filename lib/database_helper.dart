import 'dart:async';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  // Funkcja do inicjalizacji bazy danych
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDatabase();
      return _database!;
    }
  }

  // Funkcja do utworzenia bazy danych
  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'task_manager.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // Funkcja do tworzenia tabel w bazie
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        category TEXT,
        priority TEXT,
        dueDate TEXT,
        status TEXT
      )
    ''');
  }

  // Funkcja do dodawania zadania
  Future<int> insertTask(Map<String, dynamic> task) async {
    Database db = await database;
    return await db.insert('tasks', task);
  }

  // Funkcja do pobierania wszystkich zadań
  Future<List<Map<String, dynamic>>> getTasks() async {
    Database db = await database;
    return await db.query('tasks');
  }

  // Funkcja do aktualizacji zadania
  Future<int> updateTask(Map<String, dynamic> task) async {
    Database db = await database;
    return await db.update('tasks', task, where: 'id = ?', whereArgs: [task['id']]);
  }

  // Funkcja do usuwania zadania
  Future<int> deleteTask(int id) async {
    Database db = await database;
    return await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }
}
