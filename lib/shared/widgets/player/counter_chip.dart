import 'package:flutter/material.dart';

class CounterChip extends StatelessWidget {
  final Widget icon;
  final int count;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final Color? countColor;

  const CounterChip({
    required this.icon,
    required this.count,
    required this.onTap,
    required this.onLongPress,
    this.countColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            const SizedBox(width: 4),
            Text(
              '$count',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: countColor,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
