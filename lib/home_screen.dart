import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasktodo/task_list.dart';
import 'package:tasktodo/task_provider.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'To-Do List',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.clear_all),
            onPressed: () {
              Provider.of<TaskProvider>(context, listen: false).deleteSelectedTasks();
            },
            tooltip: 'Clear All Tasks',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<TaskProvider>(
          builder: (context, taskProvider, child) {
            return taskProvider.tasks.isEmpty
                ? const Center(
              child: Text(
                'No tasks yet! Add one to get started.',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  color: Colors.black54,
                ),
              ),
            )
                : TaskList(tasks: taskProvider.tasks);
          },
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [Colors.black, Colors.grey.shade600],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        child: FloatingActionButton(
          backgroundColor: Colors.transparent,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TaskScreen()),
            );
          },
          tooltip: 'Add Task',
          child: const Icon(Icons.add, color: Colors.white, size: 30),
        ),
      ),
    );
  }
}