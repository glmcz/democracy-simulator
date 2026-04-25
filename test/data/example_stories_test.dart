import 'package:flutter_test/flutter_test.dart';
import 'package:democracy_simulator/data/example_stories.dart';
import 'package:democracy_simulator/services/story_engine.dart';

void main() {
  group('Example Stories', () {
    test('example story loads and has valid structure', () {
      expect(exampleStoryChain.id, 'refugee_crisis');
      expect(exampleStoryChain.startCardId, 'card_welcome');
      expect(exampleStoryChain.cards.length, greaterThanOrEqualTo(5));
    });

    test('all cards in story have 2-4 choices', () {
      for (final card in exampleStoryChain.cards.values) {
        expect(
          card.choices.length,
          greaterThanOrEqualTo(2),
          reason: 'Card ${card.id} has < 2 choices',
        );
        expect(
          card.choices.length,
          lessThanOrEqualTo(4),
          reason: 'Card ${card.id} has > 4 choices',
        );
      }
    });

    test('start card exists', () {
      expect(
        exampleStoryChain.getCard(exampleStoryChain.startCardId),
        isNotNull,
      );
    });

    test('all next_card_ids point to valid cards', () {
      for (final card in exampleStoryChain.cards.values) {
        for (final choice in card.choices) {
          expect(
            exampleStoryChain.getCard(choice.nextCardId),
            isNotNull,
            reason:
                'Card ${card.id}, choice "${choice.text}" points to missing card ${choice.nextCardId}',
          );
        }
      }
    });

    test('story engine can play through example', () {
      final engine = StoryEngine(storyChain: exampleStoryChain);

      expect(engine.currentCardId, 'card_welcome');
      expect(engine.thermometerValue, 50);

      // Play through several choices
      engine.makeChoice(0); // Welcome them, prepare shelter (+25)
      expect(engine.thermometerValue, 75);

      engine.makeChoice(0); // Fund community integration (+20)
      expect(engine.thermometerValue, 95);

      engine.makeChoice(0); // Celebrate and expand (+15)
      expect(engine.thermometerValue, 100); // Clamped at 100

      // Verify we reached an end card
      final currentCard = engine.currentCard;
      expect(currentCard, isNotNull);
      expect(currentCard!.id, 'card_end_positive');
    });

    test('thermometer range [0, 100]', () {
      final engine = StoryEngine(storyChain: exampleStoryChain);

      engine.makeChoice(1); // Turn them away (-20)
      expect(engine.thermometerValue, 30);

      engine.makeChoice(1); // No regrets (-15)
      expect(engine.thermometerValue, 15);

      engine.makeChoice(0); // Strengthen borders (-10)
      expect(engine.thermometerValue, 5);
    });

    test('story has 10+ cards', () {
      expect(exampleStoryChain.cards.length, greaterThanOrEqualTo(10));
    });
  });
}
