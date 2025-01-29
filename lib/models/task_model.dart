<<<<<<< HEAD
import 'package:hive/hive.dart';

part 'task_model.g.dart'; // Auto-generated file

@HiveType(typeId: 0) // Unique ID for Hive object
class Task {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String category;

  @HiveField(4)
  final String dueDate;

  @HiveField(5)
=======
class Task {
  final String id;
  final String title;
  final String description;
  final String category;
  final String dueDate;
>>>>>>> 56cc2617df886f99a5b098a880e3ce3649b1a942
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.dueDate,
    this.isCompleted = false,
  });

  // Convert a Task to a Map for database storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'dueDate': dueDate,
<<<<<<< HEAD
      'isCompleted': isCompleted ? 1 : 0,
=======
      'isCompleted': isCompleted ? 1 : 0, // Store as integer (1 for true, 0 for false)
>>>>>>> 56cc2617df886f99a5b098a880e3ce3649b1a942
    };
  }

  // Create a Task from a Map
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      category: map['category'],
      dueDate: map['dueDate'],
      isCompleted: map['isCompleted'] == 1,
    );
  }
}
