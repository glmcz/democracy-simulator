import 'package:flutter/material.dart';

class Thermometer extends StatelessWidget {
  final int value; // 0-100
  final String label;

  const Thermometer({
    super.key,
    required this.value,
    this.label = 'Human Orientation',
  }) : assert(value >= 0 && value <= 100);

  Color _getColor(int val) {
    if (val < 25) return Colors.blue; // Cold
    if (val < 50) return Colors.cyan; // Cool
    if (val < 75) return Colors.orange; // Warm
    return Colors.red; // Hot (most human-oriented)
  }

  @override
  Widget build(BuildContext context) {
    final clampedValue = value.clamp(0, 100);
    final percentage = clampedValue / 100.0;
    final barColor = _getColor(clampedValue);
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: percentage,
                  minHeight: isMobile ? 20 : 24,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(barColor),
                ),
              ),
            ),
            SizedBox(width: 12),
            SizedBox(
              width: 50,
              child: Text(
                '$clampedValue',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: isMobile ? 14 : 16,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
