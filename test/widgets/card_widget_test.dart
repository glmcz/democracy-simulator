import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:democracy_simulator/generated_l10n/app_localizations.dart';
import 'package:democracy_simulator/models/card.dart' as card_model;
import 'package:democracy_simulator/widgets/card_widget.dart';

void main() {
  group('CardWidget', () {
    late card_model.Card testCard;

    setUp(() {
      testCard = card_model.Card(
        id: 'card1',
        question: 'What do you do?',
        imagePath: 'assets/card1.png',
        choices: [
          card_model.Choice(text: 'Help', thermometerDelta: 10, nextCardId: 'card2'),
          card_model.Choice(text: 'Ignore', thermometerDelta: -5, nextCardId: 'card3'),
          card_model.Choice(text: 'Delay', thermometerDelta: 0, nextCardId: 'card4'),
        ],
      );
    });

    testWidgets('renders question text', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: CardWidget(
              card: testCard,
              onChoiceSelected: (_) {},
            ),
          ),
        ),
      );

      expect(find.text('What do you do?'), findsOneWidget);
    });

    testWidgets('renders correct number of choice buttons', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: CardWidget(
              card: testCard,
              onChoiceSelected: (_) {},
            ),
          ),
        ),
      );

      expect(find.text('Help'), findsOneWidget);
      expect(find.text('Ignore'), findsOneWidget);
      expect(find.text('Delay'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsNWidgets(3));
    });

    testWidgets('onChoiceSelected fires with correct index', (WidgetTester tester) async {
      int? selectedIndex;

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: CardWidget(
              card: testCard,
              onChoiceSelected: (index) => selectedIndex = index,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Ignore'));
      expect(selectedIndex, 1);

      await tester.tap(find.text('Delay'));
      expect(selectedIndex, 2);
    });

    testWidgets('enforces 2-4 choices (via Card validation)', (WidgetTester tester) async {
      expect(
        () => card_model.Card(
          id: 'card1',
          question: 'Test',
          imagePath: 'assets/test.png',
          choices: [
            card_model.Choice(text: 'A', thermometerDelta: 0, nextCardId: 'next'),
          ], // Only 1 choice
        ),
        throwsAssertionError,
      );
    });
  });
}
