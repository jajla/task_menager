import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'task.dart';


class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];
  final DatabaseHelper _dbHelper = DatabaseHelper();

  List<Task> get tasks => _tasks;

  // Załaduj wszystkie zadania z bazy danych
  Future<void> loadTasks() async {
   // _tasks = await _dbHelper.getTasks();
    notifyListeners();
  }

  // Dodaj nowe zadanie
  Future<void> addTask(Task task) async {
    await _dbHelper.insertTask(task.toMap());
    loadTasks();
  }

  // Usuń zadanie
  Future<void> deleteTask(int id) async {
    await _dbHelper.deleteTask(id);
    loadTasks();
  }

  // Zaktualizuj zadanie
  Future<void> updateTask(Task task) async {
    await _dbHelper.updateTask(task.toMap());
    loadTasks();
  }
}
