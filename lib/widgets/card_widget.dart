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
    final isMobile = MediaQuery.of(context).size.width < 600;
    final padding = isMobile ? 16.0 : 24.0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Question at top
        Padding(
          padding: EdgeInsets.symmetric(horizontal: padding, vertical: padding),
          child: Text(
            card.question,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontSize: isMobile ? 18 : 24,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        // Image in center
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: padding),
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
          padding: EdgeInsets.all(padding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < card.choices.length; i++)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: isMobile ? 6 : 8),
                  child: SizedBox(
                    width: double.infinity,
                    child: ChoiceButton(
                      text: card.choices[i].text,
                      index: i,
                      onTap: () => onChoiceSelected(i),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
