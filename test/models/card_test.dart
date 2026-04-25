import 'package:flutter_test/flutter_test.dart';
import 'package:democracy_simulator/models/card.dart';

void main() {
  group('Choice', () {
    test('thermometer delta clamped [-100, +100]', () {
      expect(
        () => Choice(
          text: 'test',
          thermometerDelta: 101,
          nextCardId: 'card2',
        ),
        throwsAssertionError,
      );

      expect(
        () => Choice(
          text: 'test',
          thermometerDelta: -101,
          nextCardId: 'card2',
        ),
        throwsAssertionError,
      );

      expect(
        Choice(
          text: 'test',
          thermometerDelta: 0,
          nextCardId: 'card2',
        ).thermometerDelta,
        0,
      );
    });

    test('fromJson/toJson roundtrip', () {
      final choice = Choice(
        text: 'Help refugees',
        thermometerDelta: 15,
        nextCardId: 'card_2',
      );
      final json = choice.toJson();
      final restored = Choice.fromJson(json);

      expect(restored.text, choice.text);
      expect(restored.thermometerDelta, choice.thermometerDelta);
      expect(restored.nextCardId, choice.nextCardId);
    });
  });

  group('Card', () {
    test('choice count enforced [2, 4]', () {
      expect(
        () => Card(
          id: 'card1',
          question: 'What do you do?',
          imagePath: 'assets/card1.png',
          choices: [
            Choice(text: 'A', thermometerDelta: 0, nextCardId: 'card2'),
          ],
        ),
        throwsAssertionError,
      );

      expect(
        () => Card(
          id: 'card1',
          question: 'What do you do?',
          imagePath: 'assets/card1.png',
          choices: List.generate(
            5,
            (i) => Choice(
              text: 'Choice $i',
              thermometerDelta: 0,
              nextCardId: 'card2',
            ),
          ),
        ),
        throwsAssertionError,
      );

      // Valid: 2, 3, 4 choices
      for (int count = 2; count <= 4; count++) {
        expect(
          Card(
            id: 'card1',
            question: 'What do you do?',
            imagePath: 'assets/card1.png',
            choices: List.generate(
              count,
              (i) => Choice(
                text: 'Choice $i',
                thermometerDelta: 0,
                nextCardId: 'card2',
              ),
            ),
          ).choices.length,
          count,
        );
      }
    });

    test('fromJson/toJson roundtrip', () {
      final card = Card(
        id: 'card1',
        question: 'What do you do?',
        imagePath: 'assets/card1.png',
        choices: [
          Choice(text: 'Help', thermometerDelta: 10, nextCardId: 'card2'),
          Choice(text: 'Ignore', thermometerDelta: -5, nextCardId: 'card3'),
        ],
      );
      final json = card.toJson();
      final restored = Card.fromJson(json);

      expect(restored.id, card.id);
      expect(restored.question, card.question);
      expect(restored.imagePath, card.imagePath);
      expect(restored.choices.length, 2);
      expect(restored.choices[0].text, 'Help');
    });
  });
}
