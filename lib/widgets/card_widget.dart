import 'dart:io';
import 'package:flutter/material.dart';
import 'package:democracy_simulator/generated_l10n/app_localizations.dart';
import 'package:democracy_simulator/models/card.dart' as card_model;
import 'package:democracy_simulator/utils/image_opener.dart';
import 'choice_button.dart';

class CardWidget extends StatelessWidget {
  final card_model.Card card;
  final void Function(int choiceIndex) onChoiceSelected;

  const CardWidget({
    super.key,
    required this.card,
    required this.onChoiceSelected,
  });

  Widget _buildImage(String imagePath) {
    if (imagePath.startsWith('assets/')) {
      return Image.asset(
        imagePath,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey[300],
            child: Center(
              child: Text(AppLocalizations.of(context)!.imageNotFound),
            ),
          );
        },
      );
    } else {
      return Image.file(
        File(imagePath),
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey[300],
            child: Center(
              child: Text(AppLocalizations.of(context)!.imageNotFound),
            ),
          );
        },
      );
    }
  }

  Future<void> _openImage(BuildContext context, String imagePath) async {
    if (imagePath.startsWith('assets/')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.imageNotFound)),
      );
      return;
    }
    try {
      await ImageOpener.openImage(imagePath);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error opening image: $e')),
        );
      }
    }
  }

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
            child: GestureDetector(
              onTap: () => _openImage(context, card.imagePath),
              child: _buildImage(card.imagePath),
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
