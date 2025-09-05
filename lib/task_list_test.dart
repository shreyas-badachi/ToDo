import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:tasktodo/task_list.dart';
import 'package:tasktodo/task_provider.dart';

void main() {
  testWidgets('TaskList displays tasks correctly', (WidgetTester tester) async {
    final taskProvider = TaskProvider();
    taskProvider.addTask('Test Task', 'Test Description');

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (_) => taskProvider,
          child: const Scaffold(
            body: TaskList(tasks: []),
          ),
        ),
      ),
    );

    // Update the TaskList with the provider's tasks
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (_) => taskProvider,
          child: Consumer<TaskProvider>(
            builder: (context, provider, child) => TaskList(tasks: provider.tasks),
          ),
        ),
      ),
    );

    expect(find.text('Test Task'), findsOneWidget);
    expect(find.text('Test Description'), findsOneWidget);
    expect(find.byType(Checkbox), findsOneWidget);
    expect(find.byIcon(Icons.delete), findsOneWidget);
  });
}