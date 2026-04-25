import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:democracy_simulator/models/card.dart' as card_model;
import 'package:democracy_simulator/models/story_chain.dart';
import 'package:democracy_simulator/widgets/story_chain_editor.dart';

void main() {
  group('StoryChainEditor', () {
    testWidgets('renders title', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StoryChainEditor(
              onSave: (_) {},
            ),
          ),
        ),
      );

      expect(find.text('Story Chain Editor'), findsOneWidget);
    });

    testWidgets('displays empty state when no cards', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StoryChainEditor(
              onSave: (_) {},
            ),
          ),
        ),
      );

      expect(find.text('No cards yet'), findsOneWidget);
    });

    testWidgets('populates from initial chain', (WidgetTester tester) async {
      final card1 = card_model.Card(
        id: 'card1',
        question: 'Question 1?',
        imagePath: 'assets/1.png',
        choices: [
          card_model.Choice(text: 'A', thermometerDelta: 0, nextCardId: 'card2'),
          card_model.Choice(text: 'B', thermometerDelta: 0, nextCardId: 'card2'),
        ],
      );

      final chain = StoryChain(
        id: 'test_chain',
        startCardId: 'card1',
        cards: {'card1': card1},
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StoryChainEditor(
              initialChain: chain,
              onSave: (_) {},
            ),
          ),
        ),
      );

      expect(find.text('test_chain'), findsOneWidget);
      expect(find.text('card1'), findsWidgets);
      expect(find.text('Cards (1)'), findsOneWidget);
    });

    testWidgets('displays save button', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StoryChainEditor(
              onSave: (_) {},
            ),
          ),
        ),
      );

      expect(find.text('Save Chain'), findsOneWidget);
    });

    testWidgets('can select cards from list', (WidgetTester tester) async {
      final card1 = card_model.Card(
        id: 'card1',
        question: 'Q1',
        imagePath: 'assets/1.png',
        choices: [
          card_model.Choice(text: 'A', thermometerDelta: 0, nextCardId: 'card2'),
          card_model.Choice(text: 'B', thermometerDelta: 0, nextCardId: 'card2'),
        ],
      );

      final chain = StoryChain(
        id: 'test',
        startCardId: 'card1',
        cards: {'card1': card1},
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StoryChainEditor(
              initialChain: chain,
              onSave: (_) {},
            ),
          ),
        ),
      );

      expect(find.byType(ListTile), findsOneWidget);
    });
  });
}
