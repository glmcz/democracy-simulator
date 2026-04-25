import 'card.dart';

class StoryChain {
  final String id;
  final String startCardId;
  final Map<String, Card> cards;

  const StoryChain({
    required this.id,
    required this.startCardId,
    required this.cards,
  });

  factory StoryChain.fromJson(Map<String, dynamic> json) {
    final cardsData = json['cards'] as Map<String, dynamic>;
    final cards = cardsData.map(
      (key, value) => MapEntry(key, Card.fromJson(value as Map<String, dynamic>)),
    );
    return StoryChain(
      id: json['id'] as String,
      startCardId: json['start_card_id'] as String,
      cards: cards,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'start_card_id': startCardId,
    'cards': cards.map((key, card) => MapEntry(key, card.toJson())),
  };

  Card? getCard(String cardId) => cards[cardId];

  Card? getNextCard(String cardId, int choiceIndex) {
    final card = getCard(cardId);
    if (card == null || choiceIndex < 0 || choiceIndex >= card.choices.length) {
      return null;
    }
    final nextCardId = card.choices[choiceIndex].nextCardId;
    return getCard(nextCardId);
  }
}
