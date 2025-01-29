import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task_model.dart';
import '../providers/task_provider.dart';

class AddEditTaskScreen extends StatefulWidget {
  final Task? task;

  AddEditTaskScreen({this.task});

  @override
  _AddEditTaskScreenState createState() => _AddEditTaskScreenState();
}

class _AddEditTaskScreenState extends State<AddEditTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  String _category = '';
  String _dueDate = '';

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _title = widget.task!.title;
      _description = widget.task!.description;
      _category = widget.task!.category;
      _dueDate = widget.task!.dueDate;
    }
  }

  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final task = Task(
        id: widget.task?.id ?? DateTime.now().toString(),
        title: _title.isEmpty ? 'Untitled Task' : _title,
        description: _description.isEmpty ? 'No description' : _description,
        category: _category.isEmpty ? 'General' : _category,
        dueDate: _dueDate,
      );

      final provider = Provider.of<TaskProvider>(context, listen: false);
      if (widget.task == null) {
        provider.addTask(task);
      } else {
        provider.updateTask(task);
      }

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null ? 'Add Task' : 'Edit Task'),
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: const Text(
            "⬅️",
            style: TextStyle(fontSize: 24),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF80CBC4), Color(0xFF4CAF50)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildTextField(
                    label: 'Title',
                    value: _title,
                    onChanged: (value) => _title = value,
                    isMandatory: true,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    label: 'Description',
                    value: _description,
                    onChanged: (value) => _description = value,
                  ),
                  const SizedBox(height: 16),
                  _buildDropdownField(),
                  const SizedBox(height: 16),
                  _buildDatePicker(),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: _saveTask,
                    icon: const Text(
                      "✅",
                      style: TextStyle(fontSize: 18),
                    ),
                    label: const Text(
                      'Save',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String value,
    required Function(String) onChanged,
    bool isMandatory = false,
  }) {
    return TextFormField(
      initialValue: value,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[400]!),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.teal),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      validator: (value) {
        if (isMandatory && value!.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
      onChanged: onChanged,
    );
  }

  Widget _buildDropdownField() {
    return DropdownButtonFormField<String>(
      value: _category.isEmpty ? null : _category,
      decoration: InputDecoration(
        labelText: 'Category',
        labelStyle: const TextStyle(color: Colors.black),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[400]!),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.teal),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      icon: const Text(
        "⬇️",
        style: TextStyle(fontSize: 20),
      ), // Replaced the dropdown arrow with an emoji
      items: [
        'Work 💼',
        'Personal 🎯',
        'Shopping 🛒',
        'Fitness 🏋️',
      ]
          .map((category) => DropdownMenuItem(
                value: category,
                child: Text(
                  category,
                  style: const TextStyle(color: Colors.black),
                ),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          _category = value ?? 'General';
        });
      },
    );
  }

  Widget _buildDatePicker() {
    return TextFormField(
      controller: TextEditingController(text: _dueDate),
      decoration: InputDecoration(
        labelText: 'Due Date',
        labelStyle: const TextStyle(color: Colors.black),
        suffixIcon: const Text(
          "📅",
          style: TextStyle(fontSize: 24),
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[400]!),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.teal),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          setState(() {
            _dueDate =
                "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
          });
        }
      },
    );
  }
}
