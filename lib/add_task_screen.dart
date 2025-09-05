import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasktodo/task.dart';
import 'package:tasktodo/task_provider.dart';

class TaskScreen extends StatelessWidget {
  final Task? task;

  const TaskScreen({super.key, this.task});

  @override
  Widget build(BuildContext context) {
    final isEditing = task != null;
    final titleController = TextEditingController(text: task?.title ?? '');
    final descriptionController = TextEditingController(text: task?.description ?? '');

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Task' : 'Add Task'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Task Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Task Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty) {
                  final taskProvider = Provider.of<TaskProvider>(context, listen: false);
                  if (isEditing) {
                    taskProvider.updateTask(
                      task!.id,
                      titleController.text,
                      descriptionController.text,
                      task!.isCompleted,
                    );
                  } else {
                    taskProvider.addTask(
                      titleController.text,
                      descriptionController.text,
                    );
                  }
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: Text(isEditing ? 'Update Task' : 'Add Task', style: const TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}