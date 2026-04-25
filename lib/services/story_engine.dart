import 'package:democracy_simulator/models/card.dart' as card_model;
import 'package:democracy_simulator/models/story_chain.dart';

class StoryEngine {
  final StoryChain storyChain;
  String _currentCardId;
  int _thermometerValue = 50; // Start neutral

  StoryEngine({required this.storyChain})
      : _currentCardId = storyChain.startCardId;

  String get currentCardId => _currentCardId;
  int get thermometerValue => _thermometerValue.clamp(0, 100);

  card_model.Card? get currentCard => storyChain.getCard(_currentCardId);

  bool makeChoice(int choiceIndex) {
    final current = currentCard;
    if (current == null || choiceIndex < 0 || choiceIndex >= current.choices.length) {
      return false;
    }

    final choice = current.choices[choiceIndex];
    _thermometerValue += choice.thermometerDelta;
    _currentCardId = choice.nextCardId;

    return true;
  }

  void reset() {
    _currentCardId = storyChain.startCardId;
    _thermometerValue = 50;
  }
}
