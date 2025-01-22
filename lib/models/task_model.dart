class Task {
  final String id;
  final String title;
  final String description;
  final String category;
  final String dueDate;
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
      'isCompleted': isCompleted ? 1 : 0, // Store as integer (1 for true, 0 for false)
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
