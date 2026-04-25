import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:democracy_simulator/widgets/thermometer.dart';

void main() {
  group('Thermometer', () {
    testWidgets('displays value 0-100', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Thermometer(value: 50),
          ),
        ),
      );

      expect(find.text('50'), findsOneWidget);
    });

    testWidgets('clamps value out of range', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Thermometer(value: 75),
          ),
        ),
      );

      expect(find.text('75'), findsOneWidget);
    });

    testWidgets('renders progress bar', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Thermometer(value: 50),
          ),
        ),
      );

      expect(find.byType(LinearProgressIndicator), findsOneWidget);
    });

    testWidgets('value enforced [0, 100] at construction', (WidgetTester tester) async {
      expect(
        () => Thermometer(value: 101),
        throwsAssertionError,
      );

      expect(
        () => Thermometer(value: -1),
        throwsAssertionError,
      );
    });

    testWidgets('displays custom label', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Thermometer(value: 50, label: 'Test Label'),
          ),
        ),
      );

      expect(find.text('Test Label'), findsOneWidget);
    });

    testWidgets('color changes with value', (WidgetTester tester) async {
      // Blue: < 25
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Thermometer(value: 10),
          ),
        ),
      );

      LinearProgressIndicator indicator = find.byType(LinearProgressIndicator).evaluate().first.widget as LinearProgressIndicator;
      expect((indicator.valueColor as AlwaysStoppedAnimation<Color>).value, Colors.blue);

      // Orange: 50-75
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Thermometer(value: 60),
          ),
        ),
      );
      await tester.pump();

      indicator = find.byType(LinearProgressIndicator).evaluate().first.widget as LinearProgressIndicator;
      expect((indicator.valueColor as AlwaysStoppedAnimation<Color>).value, Colors.orange);

      // Red: >= 75
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Thermometer(value: 90),
          ),
        ),
      );
      await tester.pump();

      indicator = find.byType(LinearProgressIndicator).evaluate().first.widget as LinearProgressIndicator;
      expect((indicator.valueColor as AlwaysStoppedAnimation<Color>).value, Colors.red);
    });
  });
}
