import 'package:flutter/material.dart';
import 'task.dart'; // Import klasy Task, którą wcześniej stworzyłeś
import 'database_helper.dart'; // Import bazy danych

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];
  final DatabaseHelper _dbHelper = DatabaseHelper();

  List<Task> get tasks => _tasks;

  // Załaduj wszystkie zadania z bazy danych
  Future<void> loadTasks() async {
    final taskList = await _dbHelper.getTasks();
    _tasks = taskList.map((taskMap) => Task.fromMap(taskMap)).toList();
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

  // Filtrowanie zadań na podstawie statusu (completed, pending, etc.)
  void filterTasksByStatus(String status) {
    if (status == 'completed') {
      _tasks = _tasks.where((task) => task.status == 'completed').toList();
    } else if (status == 'pending') {
      _tasks = _tasks.where((task) => task.status == 'pending').toList();
    } else {
      loadTasks(); // Ładujemy wszystkie zadania, jeśli status jest "All"
    }
    notifyListeners();
  }
}
