import 'package:flutter_test/flutter_test.dart';
import 'package:democracy_simulator/models/card.dart' as card_model;
import 'package:democracy_simulator/models/story_chain.dart';
import 'package:democracy_simulator/services/story_engine.dart';
import 'package:democracy_simulator/services/story_persistence.dart';

void main() {
  group('Design Mode Integration', () {
    test('create story chain end-to-end', () {
      // 1. Create cards using CardEditor data
      final card1 = card_model.Card(
        id: 'card1',
        question: 'Welcome to the town. Your first crisis: budget dispute.',
        imagePath: 'assets/crisis1.png',
        choices: [
          card_model.Choice(
            text: 'Fund education',
            thermometerDelta: 15,
            nextCardId: 'card2',
          ),
          card_model.Choice(
            text: 'Fund defense',
            thermometerDelta: -10,
            nextCardId: 'card3',
          ),
        ],
      );

      final card2 = card_model.Card(
        id: 'card2',
        question: 'Education funded. Schools thrive. What about healthcare?',
        imagePath: 'assets/education.png',
        choices: [
          card_model.Choice(
            text: 'Fund healthcare',
            thermometerDelta: 20,
            nextCardId: 'card4',
          ),
          card_model.Choice(
            text: 'Reduce taxes',
            thermometerDelta: -5,
            nextCardId: 'card4',
          ),
        ],
      );

      final card3 = card_model.Card(
        id: 'card3',
        question: 'Defense prioritized. Town feels safe but schools suffer.',
        imagePath: 'assets/defense.png',
        choices: [
          card_model.Choice(
            text: 'Fix schools now',
            thermometerDelta: 25,
            nextCardId: 'card4',
          ),
          card_model.Choice(
            text: 'Maintain defense',
            thermometerDelta: -15,
            nextCardId: 'card4',
          ),
        ],
      );

      final card4 = card_model.Card(
        id: 'card4',
        question: 'End: Town reflects your values.',
        imagePath: 'assets/end.png',
        choices: [
          card_model.Choice(
            text: 'Restart',
            thermometerDelta: 0,
            nextCardId: 'card1',
          ),
          card_model.Choice(
            text: 'Exit',
            thermometerDelta: 0,
            nextCardId: 'card4',
          ),
        ],
      );

      // 2. Create story chain (using StoryChainEditor logic)
      final chain = StoryChain(
        id: 'new_story',
        startCardId: 'card1',
        cards: {
          'card1': card1,
          'card2': card2,
          'card3': card3,
          'card4': card4,
        },
      );

      // 3. Verify chain structure
      expect(chain.cards.length, 4);
      expect(chain.startCardId, 'card1');

      // 4. Verify all cards have valid choice counts
      for (final card in chain.cards.values) {
        expect(card.choices.length, greaterThanOrEqualTo(2));
        expect(card.choices.length, lessThanOrEqualTo(4));
      }

      // 5. Verify all next_card_ids point to valid cards
      for (final card in chain.cards.values) {
        for (final choice in card.choices) {
          expect(
            chain.getCard(choice.nextCardId),
            isNotNull,
            reason: 'Card ${card.id} choice "${choice.text}" points to missing ${choice.nextCardId}',
          );
        }
      }

      // 6. Serialize to JSON (using StoryPersistence)
      final json = StoryPersistence.chainToJsonString(chain);
      expect(json.contains('new_story'), true);
      expect(json.contains('card1'), true);

      // 7. Deserialize and verify integrity
      final restored = StoryPersistence.deserializeChain(json);
      expect(restored.id, 'new_story');
      expect(restored.cards.length, 4);

      // 8. Play through story (using StoryEngine)
      final engine = StoryEngine(storyChain: restored);
      expect(engine.currentCardId, 'card1');
      expect(engine.thermometerValue, 50);

      // Play path 1: fund education → fund healthcare
      engine.makeChoice(0);
      expect(engine.currentCardId, 'card2');
      expect(engine.thermometerValue, 65); // 50 + 15

      engine.makeChoice(0);
      expect(engine.currentCardId, 'card4');
      expect(engine.thermometerValue, 85); // 65 + 20

      // 9. Reset and play path 2: fund defense → fix schools
      engine.reset();
      expect(engine.currentCardId, 'card1');
      expect(engine.thermometerValue, 50);

      engine.makeChoice(1);
      expect(engine.currentCardId, 'card3');
      expect(engine.thermometerValue, 40); // 50 - 10

      engine.makeChoice(0);
      expect(engine.currentCardId, 'card4');
      expect(engine.thermometerValue, 65); // 40 + 25

      // All tests passed: designer can create → serialize → play
    });

    test('designer can create multiple story chains', () {
      // Create two different stories
      final story1Card = card_model.Card(
        id: 'story1_card',
        question: 'Story 1 Question',
        imagePath: 'assets/story1.png',
        choices: [
          card_model.Choice(text: 'A', thermometerDelta: 0, nextCardId: 'story1_card'),
          card_model.Choice(text: 'B', thermometerDelta: 0, nextCardId: 'story1_card'),
        ],
      );

      final story2Card = card_model.Card(
        id: 'story2_card',
        question: 'Story 2 Question',
        imagePath: 'assets/story2.png',
        choices: [
          card_model.Choice(text: 'X', thermometerDelta: 0, nextCardId: 'story2_card'),
          card_model.Choice(text: 'Y', thermometerDelta: 0, nextCardId: 'story2_card'),
        ],
      );

      final chain1 = StoryChain(
        id: 'story1',
        startCardId: 'story1_card',
        cards: {'story1_card': story1Card},
      );

      final chain2 = StoryChain(
        id: 'story2',
        startCardId: 'story2_card',
        cards: {'story2_card': story2Card},
      );

      // Serialize both
      final json1 = StoryPersistence.chainToJsonString(chain1);
      final json2 = StoryPersistence.chainToJsonString(chain2);

      // Deserialize and verify they're independent
      final restored1 = StoryPersistence.deserializeChain(json1);
      final restored2 = StoryPersistence.deserializeChain(json2);

      expect(restored1.id, 'story1');
      expect(restored2.id, 'story2');
      expect(restored1.id, isNot(restored2.id));
    });
  });
}
