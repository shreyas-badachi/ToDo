import 'package:flutter/material.dart';
import 'package:tasktodo/task.dart';
import 'package:uuid/uuid.dart';

class TaskProvider with ChangeNotifier {
  final List<Task> _tasks = [];
  final List<String> _selectedTasks = [];

  List<Task> get tasks => _tasks;
  List<String> get selectedTasks => _selectedTasks;

  void addTask(String title, String description) {
    final task = Task(
      id: const Uuid().v4(),
      title: title,
      description: description,
    );
    _tasks.add(task);
    notifyListeners();
  }

  void updateTask(String id, String title, String description, bool isCompleted) {
    final task = _tasks.firstWhere((task) => task.id == id);
    task.title = title;
    task.description = description;
    task.isCompleted = isCompleted;
    notifyListeners();
  }

  void toggleTaskStatus(String id) {
    final task = _tasks.firstWhere((task) => task.id == id);
    task.isCompleted = !task.isCompleted;
    notifyListeners();
  }

  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    _selectedTasks.remove(id);
    notifyListeners();
  }

  void toggleTaskSelection(String id) {
    if (_selectedTasks.contains(id)) {
      _selectedTasks.remove(id);
    } else {
      _selectedTasks.add(id);
    }
    notifyListeners();
  }

  void deleteSelectedTasks() {
    _tasks.removeWhere((task) => _selectedTasks.contains(task.id));
    _selectedTasks.clear();
    notifyListeners();
  }
}