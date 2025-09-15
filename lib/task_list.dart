import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasktodo/task.dart';
import 'package:tasktodo/task_provider.dart';
import 'add_task_screen.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;

  const TaskList({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        return Column(
          children: [
            if (taskProvider.selectedTasks.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    taskProvider.deleteSelectedTasks();
                  },
                  icon: const Icon(Icons.delete, size: 20),
                  label: const Text(
                    'Delete Selected',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 8,
                    shadowColor: Colors.black.withOpacity(0.3),
                  ),
                ),
              ),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  final isSelected = taskProvider.selectedTasks.contains(task.id);

                  return GestureDetector(
                    onLongPress: () {
                      taskProvider.toggleTaskSelection(task.id);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        gradient: isSelected
                            ? LinearGradient(
                          colors: [Colors.black, Colors.grey.shade600],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                            : LinearGradient(
                          colors: [
                            Colors.white,
                            Colors.grey.shade100,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 15,
                            spreadRadius: isSelected ? 4 : 1,
                            offset: const Offset(-4, -4),
                          ),
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 15,
                            spreadRadius: isSelected ? 4 : 1,
                            offset: const Offset(4, 4),
                          ),
                        ],
                        border: Border.all(
                          color: isSelected ? Colors.black : Colors.grey.shade300,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        title: Text(
                          task.title,
                          style: TextStyle(
                            color: Colors.black,
                            decoration: task.isCompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        subtitle: task.description.isNotEmpty
                            ? Text(
                          task.description,
                          style: TextStyle(
                            color: Colors.black54,
                            decoration: task.isCompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            fontFamily: 'Poppins',
                          ),
                        )
                            : null,
                        trailing: IconButton(
                          icon: const Icon(Icons.edit, color: Colors.black),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TaskScreen(task: task),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}