import 'package:flutter_test/flutter_test.dart';
import 'package:democracy_simulator/models/card.dart';
import 'package:democracy_simulator/models/story_chain.dart';

void main() {
  group('StoryChain', () {
    late StoryChain storyChain;

    setUp(() {
      final card1 = Card(
        id: 'card1',
        question: 'Start: Help refugees?',
        imagePath: 'assets/card1.png',
        choices: [
          Choice(text: 'Yes', thermometerDelta: 20, nextCardId: 'card2'),
          Choice(text: 'No', thermometerDelta: -10, nextCardId: 'card3'),
          Choice(text: 'Maybe later', thermometerDelta: 0, nextCardId: 'card4'),
        ],
      );

      final card2 = Card(
        id: 'card2',
        question: 'You helped. What next?',
        imagePath: 'assets/card2.png',
        choices: [
          Choice(text: 'Build shelter', thermometerDelta: 15, nextCardId: 'card5'),
          Choice(text: 'Leave', thermometerDelta: -20, nextCardId: 'card6'),
        ],
      );

      final card3 = Card(
        id: 'card3',
        question: 'You ignored them. Regret?',
        imagePath: 'assets/card3.png',
        choices: [
          Choice(text: 'Yes, help now', thermometerDelta: 25, nextCardId: 'card5'),
          Choice(text: 'No regrets', thermometerDelta: -15, nextCardId: 'card6'),
        ],
      );

      final card4 = Card(
        id: 'card4',
        question: 'Still waiting to decide?',
        imagePath: 'assets/card4.png',
        choices: [
          Choice(text: 'Decide yes', thermometerDelta: 10, nextCardId: 'card2'),
          Choice(text: 'Decide no', thermometerDelta: -5, nextCardId: 'card3'),
        ],
      );

      final card5 = Card(
        id: 'card5',
        question: 'End: You did good.',
        imagePath: 'assets/card5.png',
        choices: [
          Choice(text: 'Start over', thermometerDelta: 0, nextCardId: 'card1'),
          Choice(text: 'End game', thermometerDelta: 0, nextCardId: 'card5'),
        ],
      );

      final card6 = Card(
        id: 'card6',
        question: 'End: Town suffered.',
        imagePath: 'assets/card6.png',
        choices: [
          Choice(text: 'Start over', thermometerDelta: 0, nextCardId: 'card1'),
          Choice(text: 'End game', thermometerDelta: 0, nextCardId: 'card6'),
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
          'card5': card5,
          'card6': card6,
        },
      );
    });

    test('deterministic routing: card + choice → next_card always same', () {
      // card1, choice 0 (Yes) → card2
      final next1a = storyChain.getNextCard('card1', 0);
      expect(next1a?.id, 'card2');

      final next1b = storyChain.getNextCard('card1', 0);
      expect(next1b?.id, 'card2');

      expect(identical(next1a, next1b), true);

      // card1, choice 1 (No) → card3
      final next2 = storyChain.getNextCard('card1', 1);
      expect(next2?.id, 'card3');
    });

    test('getCard retrieves by id', () {
      expect(storyChain.getCard('card1')?.question, 'Start: Help refugees?');
      expect(storyChain.getCard('missing'), null);
    });

    test('getNextCard returns null for invalid choice', () {
      expect(storyChain.getNextCard('card1', -1), null);
      expect(storyChain.getNextCard('card1', 10), null);
      expect(storyChain.getNextCard('missing', 0), null);
    });

    test('fromJson/toJson roundtrip', () {
      final json = storyChain.toJson();
      final restored = StoryChain.fromJson(json);

      expect(restored.id, storyChain.id);
      expect(restored.startCardId, storyChain.startCardId);
      expect(restored.cards.length, storyChain.cards.length);
      expect(restored.getCard('card1')?.question, 'Start: Help refugees?');
    });
  });
}
