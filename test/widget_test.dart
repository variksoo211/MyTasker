import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mytasker/main.dart'; // Main app entry point
import 'package:mytasker/widgets/task_card.dart'; // Import TaskCard for type checking

void main() {
  testWidgets('Task list renders correctly', (WidgetTester tester) async {
    // Build the app and trigger a frame
    await tester.pumpWidget(MyTaskerApp());

    // Verify that the home screen is displayed
    expect(find.text('MyTasker'), findsOneWidget);

    // Verify that the task list is empty initially
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(TaskCard), findsNothing); // Ensure no TaskCard is displayed initially

    // Tap the '+' icon to add a new task
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Verify navigation to Add/Edit Task screen
    expect(find.text('Add Task'), findsOneWidget);
  });
}
