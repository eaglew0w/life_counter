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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon size is controlled by parent widget (Player) or IconTheme.
            // We'll trust the plan to just increase container size for touch target first.
            icon,
            const SizedBox(width: 8), // Increased spacing
            Text(
              '$count',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    // Increased style from bodyMedium
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
