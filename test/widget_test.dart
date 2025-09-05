import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tasktodo/main.dart';

void main() {
  testWidgets('Task list displays a new task', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const MyApp());

    // Initially, the task list should be empty (or no specific task)
    expect(find.text('Test Task'), findsNothing);

    // Simulate adding a task (this depends on your UI)
    // For example, tap FAB to open Add Task screen
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    // Enter task title and description
    await tester.enterText(find.byKey(const Key('taskTitle')), 'Test Task');
    await tester.enterText(find.byKey(const Key('taskDescription')), 'Test Description');

    // Tap save button
    await tester.tap(find.byKey(const Key('saveTaskButton')));
    await tester.pumpAndSettle();

    // Verify the task appears in the list
    expect(find.text('Test Task'), findsOneWidget);
    expect(find.text('Test Description'), findsOneWidget);
  });
}
