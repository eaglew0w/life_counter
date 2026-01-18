import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_counter/shared/constants/constants.dart';
import 'package:life_counter/shared/notifiers/pwa_update_state_notifier.dart';
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

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(
            vertical: sheetVerticalPadding, horizontal: sheetHorizontalPadding),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: sheetHandleWidth,
                  height: sheetHandleHeight,
                  decoration: BoxDecoration(
                    color: theme.dividerColor,
                    borderRadius: BorderRadius.circular(sheetHandleRadius),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                matchControlTitle,
                style: TextStyle(
                    fontSize: matchControlTitleFontSize,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Life Reset Button (Centrally placed in the menu for now)
              Center(
                child: ResetButton(
                  notifiers: resettableNotifiers,
                  size: menuResetButtonSize, // Larger size for menu
                ),
              ),
              const SizedBox(height: 8),
              const Center(
                  child: Text(lifeResetLabel,
                      style: TextStyle(fontSize: lifeResetLabelFontSize))),

              const Divider(height: 32),

              const Text(countersSectionTitle,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),

              // Poison Toggle
              SwitchListTile(
                title: const Text(poisonCounterLabel),
                secondary: const Text(poisonCounterSymbol,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                value: visibilityState.isPoisonVisible,
                activeTrackColor: poisonColor,
                onChanged: (value) {
                  ref
                      .read(counterVisibilityStateProvider.notifier)
                      .togglePoison();
                },
              ),

              // Speed Toggle
              SwitchListTile(
                title: const Text(speedCounterLabel),
                secondary: const Icon(Icons.speed),
                value: visibilityState.isSpeedVisible,
                activeTrackColor: speedActiveColor,
                onChanged: (value) {
                  ref
                      .read(counterVisibilityStateProvider.notifier)
                      .toggleSpeed();
                },
              ),

              const Divider(height: 32),

              // Update Check Button
              Center(
                child: TextButton.icon(
                  onPressed: () {
                    ref.read(pwaUpdateStateProvider.notifier).checkForUpdate();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Checking for updates...'),
                        duration: Duration(seconds: 2),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text(updateCheckLabel),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
