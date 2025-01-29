import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/task_model.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];
  late Box<Task> taskBox;

  TaskProvider() {
    _loadTasks();
  }

  List<Task> get tasks => List.unmodifiable(_tasks);

  /// **Load tasks from Hive when the app starts**
  void _loadTasks() async {
    taskBox = await Hive.openBox<Task>('tasks');
    _tasks = taskBox.values.toList();
    notifyListeners();
  }

  /// **Add a new task and save it in Hive**
  void addTask(Task task) {
    _tasks.add(task);
    taskBox.put(task.id, task); // Save to Hive
    notifyListeners();
  }

  /// **Update a task and save changes in Hive**
  void updateTask(Task updatedTask) {
    final index = _tasks.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      _tasks[index] = updatedTask;
      taskBox.put(updatedTask.id, updatedTask); // Save updated task in Hive
      notifyListeners();
    }
  }

  /// **Delete a task and remove it from Hive**
  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    taskBox.delete(id); // Remove from Hive
    notifyListeners();
  }
}
