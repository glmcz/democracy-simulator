import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:democracy_simulator/services/design_mode.dart';
import 'package:democracy_simulator/widgets/design_mode_toggle.dart';

void main() {
  group('DesignModeToggle', () {
    testWidgets('displays play mode initially', (WidgetTester tester) async {
      final manager = DesignModeManager();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: DesignModeToggle(manager: manager),
            ),
          ),
        ),
      );

      expect(find.text('Play Mode'), findsOneWidget);
    });

    testWidgets('displays design mode when set', (WidgetTester tester) async {
      final manager = DesignModeManager();
      manager.setMode(AppMode.design);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: DesignModeToggle(manager: manager),
            ),
          ),
        ),
      );

      expect(find.text('Design Mode'), findsOneWidget);
    });

    testWidgets('renders without error', (WidgetTester tester) async {
      final manager = DesignModeManager();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: DesignModeToggle(manager: manager),
            ),
          ),
        ),
      );

      expect(find.byType(DesignModeToggle), findsOneWidget);
    });
  });
}
