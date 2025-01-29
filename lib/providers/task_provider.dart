import 'package:flutter/material.dart';
<<<<<<< HEAD
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
=======
import '../models/task_model.dart';

class TaskProvider with ChangeNotifier {
  final List<Task> _tasks = [];
  String quote = '';

  List<Task> get tasks => List.unmodifiable(_tasks);

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

>>>>>>> 56cc2617df886f99a5b098a880e3ce3649b1a942
  void updateTask(Task updatedTask) {
    final index = _tasks.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      _tasks[index] = updatedTask;
<<<<<<< HEAD
      taskBox.put(updatedTask.id, updatedTask); // Save updated task in Hive
=======
>>>>>>> 56cc2617df886f99a5b098a880e3ce3649b1a942
      notifyListeners();
    }
  }

<<<<<<< HEAD
  /// **Delete a task and remove it from Hive**
  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    taskBox.delete(id); // Remove from Hive
=======
  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }

  Future<void> fetchQuote() async {
    // Simulate fetching a motivational quote
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    quote = "Stay motivated and keep building!"; // Example quote
>>>>>>> 56cc2617df886f99a5b098a880e3ce3649b1a942
    notifyListeners();
  }
}
