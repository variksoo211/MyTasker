import 'package:flutter/material.dart';
import '../models/task_model.dart';

class TaskProvider with ChangeNotifier {
  final List<Task> _tasks = [];
  String quote = '';

  List<Task> get tasks => List.unmodifiable(_tasks);

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void updateTask(Task updatedTask) {
    final index = _tasks.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      _tasks[index] = updatedTask;
      notifyListeners();
    }
  }

  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }

  Future<void> fetchQuote() async {
    // Simulate fetching a motivational quote
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    quote = "Stay motivated and keep building!"; // Example quote
    notifyListeners();
  }
}
