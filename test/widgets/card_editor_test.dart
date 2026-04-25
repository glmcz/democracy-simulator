import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:democracy_simulator/generated_l10n/app_localizations.dart';
import 'package:democracy_simulator/models/card.dart' as card_model;
import 'package:democracy_simulator/widgets/card_editor.dart';

void main() {
  group('CardEditor', () {
    testWidgets('renders form title', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: CardEditor(
              onSave: (_) {},
            ),
          ),
        ),
      );

      expect(find.text('Edit Card'), findsOneWidget);
    });

    testWidgets('populates fields from initial card', (WidgetTester tester) async {
      final card = card_model.Card(
        id: 'test_card',
        question: 'Test question?',
        imagePath: 'assets/test.png',
        choices: [
          card_model.Choice(text: 'Option A', thermometerDelta: 10, nextCardId: 'card2'),
          card_model.Choice(text: 'Option B', thermometerDelta: -5, nextCardId: 'card3'),
        ],
      );

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: CardEditor(
              initialCard: card,
              onSave: (_) {},
            ),
          ),
        ),
      );

      expect(find.text('test_card'), findsOneWidget);
      expect(find.text('Test question?'), findsOneWidget);
      expect(find.text('assets/test.png'), findsOneWidget);
      expect(find.text('Option A'), findsOneWidget);
      expect(find.text('Option B'), findsOneWidget);
    });

    testWidgets('renders save button', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: CardEditor(
              onSave: (_) {},
            ),
          ),
        ),
      );

      expect(find.text('Save Card'), findsOneWidget);
    });

    testWidgets('renders with initial choice count', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: CardEditor(
              onSave: (_) {},
            ),
          ),
        ),
      );

      // Should start with 2 choices (default)
      expect(find.text('Choice Text'), findsWidgets);
    });
  });
}
