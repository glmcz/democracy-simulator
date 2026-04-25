class Choice {
  final String text;
  final int thermometerDelta;
  final String nextCardId;

  const Choice({
    required this.text,
    required this.thermometerDelta,
    required this.nextCardId,
  }) : assert(thermometerDelta >= -100 && thermometerDelta <= 100);

  factory Choice.fromJson(Map<String, dynamic> json) {
    return Choice(
      text: json['text'] as String,
      thermometerDelta: json['thermometer_delta'] as int,
      nextCardId: json['next_card_id'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'text': text,
    'thermometer_delta': thermometerDelta,
    'next_card_id': nextCardId,
  };
}

class Card {
  final String id;
  final String question;
  final String imagePath;
  final List<Choice> choices;

  const Card({
    required this.id,
    required this.question,
    required this.imagePath,
    required this.choices,
  }) : assert(choices.length >= 2 && choices.length <= 4);

  factory Card.fromJson(Map<String, dynamic> json) {
    final choicesList = (json['choices'] as List<dynamic>)
        .map((c) => Choice.fromJson(c as Map<String, dynamic>))
        .toList();
    return Card(
      id: json['id'] as String,
      question: json['question'] as String,
      imagePath: json['image_path'] as String,
      choices: choicesList,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'question': question,
    'image_path': imagePath,
    'choices': choices.map((c) => c.toJson()).toList(),
  };
}
