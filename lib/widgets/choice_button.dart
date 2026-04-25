import 'package:flutter/material.dart';

class ChoiceButton extends StatelessWidget {
  final String text;
  final int index;
  final VoidCallback onTap;

  const ChoiceButton({
    super.key,
    required this.text,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        minimumSize: Size.fromHeight(48), // Android touch target minimum
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyLarge,
        textAlign: TextAlign.center,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
