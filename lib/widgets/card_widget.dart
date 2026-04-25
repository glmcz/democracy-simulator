import 'package:flutter/material.dart';
import 'package:democracy_simulator/models/card.dart' as card_model;
import 'choice_button.dart';

class CardWidget extends StatelessWidget {
  final card_model.Card card;
  final void Function(int choiceIndex) onChoiceSelected;

  const CardWidget({
    super.key,
    required this.card,
    required this.onChoiceSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Question at top
        Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            card.question,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
        ),
        // Image in center
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Image.asset(
              card.imagePath,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: Center(
                    child: Text('Image not found'),
                  ),
                );
              },
            ),
          ),
        ),
        // Choices at bottom
        Padding(
          padding: EdgeInsets.all(24),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              for (int i = 0; i < card.choices.length; i++)
                SizedBox(
                  width: MediaQuery.of(context).size.width > 600
                      ? (MediaQuery.of(context).size.width - 60) / card.choices.length
                      : 150,
                  child: ChoiceButton(
                    text: card.choices[i].text,
                    index: i,
                    onTap: () => onChoiceSelected(i),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
