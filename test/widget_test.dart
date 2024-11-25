import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:terhalkum/main.dart';  // Replace with your app's main file

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(const homepage());

    // Verify that the counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that the counter has incremented.
    expect(find.text('1'), findsOneWidget);
    expect(find.text('0'), findsNothing);
  });
}
