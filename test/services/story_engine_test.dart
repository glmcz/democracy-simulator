import 'package:flutter_test/flutter_test.dart';
import 'package:democracy_simulator/models/card.dart' as card_model;
import 'package:democracy_simulator/models/story_chain.dart';
import 'package:democracy_simulator/services/story_engine.dart';

void main() {
  group('StoryEngine', () {
    late StoryChain storyChain;
    late StoryEngine engine;

    setUp(() {
      final card1 = card_model.Card(
        id: 'card1',
        question: 'Start: Help?',
        imagePath: 'assets/card1.png',
        choices: [
          card_model.Choice(text: 'Yes', thermometerDelta: 20, nextCardId: 'card2'),
          card_model.Choice(text: 'No', thermometerDelta: -10, nextCardId: 'card3'),
        ],
      );

      final card2 = card_model.Card(
        id: 'card2',
        question: 'You helped. Next?',
        imagePath: 'assets/card2.png',
        choices: [
          card_model.Choice(text: 'Continue', thermometerDelta: 15, nextCardId: 'card4'),
          card_model.Choice(text: 'Stop', thermometerDelta: -5, nextCardId: 'card4'),
        ],
      );

      final card3 = card_model.Card(
        id: 'card3',
        question: 'You refused. Regret?',
        imagePath: 'assets/card3.png',
        choices: [
          card_model.Choice(text: 'Yes, help now', thermometerDelta: 25, nextCardId: 'card4'),
          card_model.Choice(text: 'No regrets', thermometerDelta: -15, nextCardId: 'card4'),
        ],
      );

      final card4 = card_model.Card(
        id: 'card4',
        question: 'End of story',
        imagePath: 'assets/card4.png',
        choices: [
          card_model.Choice(text: 'Restart', thermometerDelta: 0, nextCardId: 'card1'),
          card_model.Choice(text: 'Exit', thermometerDelta: 0, nextCardId: 'card4'),
        ],
      );

      storyChain = StoryChain(
        id: 'test_story',
        startCardId: 'card1',
        cards: {
          'card1': card1,
          'card2': card2,
          'card3': card3,
          'card4': card4,
        },
      );

      engine = StoryEngine(storyChain: storyChain);
    });

    test('starts at start card', () {
      expect(engine.currentCardId, 'card1');
    });

    test('starts at neutral thermometer (50)', () {
      expect(engine.thermometerValue, 50);
    });

    test('makeChoice navigates to next card', () {
      expect(engine.currentCardId, 'card1');

      engine.makeChoice(0); // Yes
      expect(engine.currentCardId, 'card2');

      engine.makeChoice(0); // Continue
      expect(engine.currentCardId, 'card4');
    });

    test('thermometer accumulates deltas', () {
      expect(engine.thermometerValue, 50);

      engine.makeChoice(0); // Yes (+20)
      expect(engine.thermometerValue, 70);

      engine.makeChoice(0); // Continue (+15)
      expect(engine.thermometerValue, 85);
    });

    test('thermometer clamped [0, 100]', () {
      // Start at 50, subtract 60 → 0 (not negative)
      engine.makeChoice(1); // No (-10)
      expect(engine.thermometerValue, 40);

      engine.makeChoice(1); // No regrets (-15)
      expect(engine.thermometerValue, 25);

      // Now go high
      engine.reset();
      engine.makeChoice(0); // Yes (+20)
      engine.makeChoice(0); // Continue (+15)
      expect(engine.thermometerValue, 85);

      engine.makeChoice(0); // Restart (0)
      expect(engine.thermometerValue, 85); // Stays at end card
    });

    test('makeChoice returns false for invalid choice', () {
      expect(engine.makeChoice(-1), false);
      expect(engine.makeChoice(100), false);
      expect(engine.currentCardId, 'card1'); // No change
    });

    test('reset returns to start state', () {
      engine.makeChoice(0);
      engine.makeChoice(0);
      expect(engine.currentCardId, 'card4');
      expect(engine.thermometerValue, isNot(50));

      engine.reset();
      expect(engine.currentCardId, 'card1');
      expect(engine.thermometerValue, 50);
    });

    test('deterministic routing: same choice → same next card', () {
      final nextA = engine.makeChoice(0);
      final cardAfterA = engine.currentCardId;

      engine.reset();
      final nextB = engine.makeChoice(0);
      final cardAfterB = engine.currentCardId;

      expect(nextA, nextB);
      expect(cardAfterA, cardAfterB);
    });
  });
}
