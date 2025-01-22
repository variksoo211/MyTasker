import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task_model.dart';
import '../providers/task_provider.dart';
import '../screens/add_edit_task_screen.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  TaskCard({required this.task});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 2,
      child: ListTile(
        title: Text(
          task.title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            decoration: task.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        subtitle: Text(
          task.description,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        trailing: Tooltip(
          message: 'Mark as ${task.isCompleted ? "incomplete" : "complete"}',
          child: Checkbox(
            value: task.isCompleted,
            activeColor: Theme.of(context).primaryColor,
            onChanged: (value) {
              final updatedTask = Task(
                id: task.id,
                title: task.title,
                description: task.description,
                category: task.category,
                dueDate: task.dueDate,
                isCompleted: value ?? false,
              );
              taskProvider.updateTask(updatedTask);
            },
          ),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddEditTaskScreen(task: task),
            ),
          );
        },
      ),
    );
  }
}
