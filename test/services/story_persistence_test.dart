import 'package:flutter_test/flutter_test.dart';
import 'package:democracy_simulator/models/card.dart' as card_model;
import 'package:democracy_simulator/models/story_chain.dart';
import 'package:democracy_simulator/services/story_persistence.dart';

void main() {
  group('StoryPersistence', () {
    late StoryChain testChain;

    setUp(() {
      final card1 = card_model.Card(
        id: 'card1',
        question: 'Start?',
        imagePath: 'assets/start.png',
        choices: [
          card_model.Choice(text: 'Yes', thermometerDelta: 10, nextCardId: 'card2'),
          card_model.Choice(text: 'No', thermometerDelta: -5, nextCardId: 'card3'),
        ],
      );

      final card2 = card_model.Card(
        id: 'card2',
        question: 'Continue?',
        imagePath: 'assets/continue.png',
        choices: [
          card_model.Choice(text: 'End', thermometerDelta: 0, nextCardId: 'card3'),
          card_model.Choice(text: 'Loop', thermometerDelta: 5, nextCardId: 'card1'),
        ],
      );

      final card3 = card_model.Card(
        id: 'card3',
        question: 'Done',
        imagePath: 'assets/end.png',
        choices: [
          card_model.Choice(text: 'Restart', thermometerDelta: 0, nextCardId: 'card1'),
          card_model.Choice(text: 'Exit', thermometerDelta: 0, nextCardId: 'card3'),
        ],
      );

      testChain = StoryChain(
        id: 'test_story',
        startCardId: 'card1',
        cards: {
          'card1': card1,
          'card2': card2,
          'card3': card3,
        },
      );
    });

    test('serialize and deserialize roundtrip', () {
      final json = StoryPersistence.serializeChain(testChain);
      final restored = StoryPersistence.deserializeChain(json);

      expect(restored.id, testChain.id);
      expect(restored.startCardId, testChain.startCardId);
      expect(restored.cards.length, testChain.cards.length);
      expect(restored.cards['card1']?.question, 'Start?');
    });

    test('chainToJsonString produces valid JSON', () {
      final jsonString = StoryPersistence.chainToJsonString(testChain);
      expect(jsonString.contains('card1'), true);
      expect(jsonString.contains('test_story'), true);
    });

    test('chainToJson returns Map', () {
      final json = StoryPersistence.chainToJson(testChain);
      expect(json, isA<Map<String, dynamic>>());
      expect(json['id'], 'test_story');
      expect(json['start_card_id'], 'card1');
      expect((json['cards'] as Map).length, 3);
    });

    test('deserialize preserves all card data', () {
      final json = StoryPersistence.serializeChain(testChain);
      final restored = StoryPersistence.deserializeChain(json);

      final originalCard = testChain.cards['card1']!;
      final restoredCard = restored.cards['card1']!;

      expect(restoredCard.id, originalCard.id);
      expect(restoredCard.question, originalCard.question);
      expect(restoredCard.imagePath, originalCard.imagePath);
      expect(restoredCard.choices.length, originalCard.choices.length);
      expect(restoredCard.choices[0].text, 'Yes');
      expect(restoredCard.choices[0].thermometerDelta, 10);
    });

    test('invalid JSON throws exception', () {
      expect(
        () => StoryPersistence.deserializeChain('invalid json'),
        throwsException,
      );
    });

    test('prettifyJson handles valid JSON', () {
      final json = StoryPersistence.chainToJsonString(testChain);
      final prettified = StoryPersistence.prettifyJson(json);
      expect(prettified.contains('card1'), true);
    });

    test('prettifyJson handles invalid JSON gracefully', () {
      final result = StoryPersistence.prettifyJson('invalid');
      expect(result, 'invalid');
    });
  });
}
