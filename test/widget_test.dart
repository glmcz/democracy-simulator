import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:democracy_simulator/main.dart';

void main() {
  testWidgets('Democracy Simulator app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const DemocracySimulatorApp());
    await tester.pumpAndSettle();

    expect(find.text('Democracy Simulator'), findsWidgets);
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });
}
