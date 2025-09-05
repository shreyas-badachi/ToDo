import 'package:flutter_test/flutter_test.dart';
import 'package:tasktodo/task.dart';

void main() {
  group('Task Model Tests', () {
    test('Task should be created with correct properties', () {
      final task = Task(
        id: '1',
        title: 'Test Task',
        description: 'Test Description',
        isCompleted: false,
      );

      expect(task.id, '1');
      expect(task.title, 'Test Task');
      expect(task.description, 'Test Description');
      expect(task.isCompleted, false);
    });

    test('Task toMap and fromMap should preserve data', () {
      final task = Task(
        id: '1',
        title: 'Test Task',
        description: 'Test Description',
        isCompleted: true,
      );

      final map = task.toMap();
      final newTask = Task.fromMap(map);

      expect(newTask.id, task.id);
      expect(newTask.title, task.title);
      expect(newTask.description, task.description);
      expect(newTask.isCompleted, task.isCompleted);
    });
  });
}