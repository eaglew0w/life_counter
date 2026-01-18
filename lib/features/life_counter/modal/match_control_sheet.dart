import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_counter/shared/constants/constants.dart';
import 'package:life_counter/shared/notifiers/resettable_notifier.dart';
import 'package:life_counter/shared/providers/providers.dart';
import 'package:life_counter/shared/widgets/button/reset_button/reset_button.dart';

class MatchControlSheet extends ConsumerWidget {
  final List<ResettableNotifier> resettableNotifiers;

  const MatchControlSheet({
    super.key,
    required this.resettableNotifiers,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final visibilityState = ref.watch(counterVisibilityStateProvider);
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: theme.dividerColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Match Control',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Life Reset Button (Centrally placed in the menu for now)
          Center(
            child: ResetButton(
              notifiers: resettableNotifiers,
              size: 64, // Larger size for menu
            ),
          ),
          const SizedBox(height: 8),
          const Center(
              child: Text('Life Reset', style: TextStyle(fontSize: 12))),

          const Divider(height: 32),

          const Text('Counters', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),

          // Poison Toggle
          SwitchListTile(
            title: const Text('Poison Counter'),
            secondary: const Text(poisonCounterSymbol,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
            value: visibilityState.isPoisonVisible,
            activeColor: poisonColor,
            onChanged: (value) {
              ref.read(counterVisibilityStateProvider.notifier).togglePoison();
            },
          ),

          // Speed Toggle
          SwitchListTile(
            title: const Text('Speed / Energy'),
            secondary: const Icon(Icons.speed),
            value: visibilityState.isSpeedVisible,
            activeColor: speedActiveColor,
            onChanged: (value) {
              ref.read(counterVisibilityStateProvider.notifier).toggleSpeed();
            },
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
