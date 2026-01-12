import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_counter/shared/widgets/button/reset_button/reset_button.dart';
import 'package:life_counter/shared/widgets/button/theme_mode_change_button/theme_mode_change_button.dart';
import 'package:life_counter/shared/notifiers/resettable_notifier.dart';
import 'package:life_counter/shared/notifiers/theme_mode_state_notifier.dart';
import 'package:life_counter/shared/models/theme_mode_state.dart';
import 'package:life_counter/shared/providers/providers.dart';

class LifeCounterScaffold extends ConsumerWidget {
  final List<ResettableNotifier> resettableNotifiers;
  final NotifierProvider<ThemeModeStateNotifier, ThemeModeState>
      themeModeProvider;
  final Widget body;

  const LifeCounterScaffold({
    required this.resettableNotifiers,
    required this.themeModeProvider,
    required this.body,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildToggleButton(
                context: context,
                ref: ref,
                icon: const Text('Φ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                isVisible:
                    ref.watch(counterVisibilityStateProvider).isPoisonVisible,
                onPressed: () => ref
                    .read(counterVisibilityStateProvider.notifier)
                    .togglePoison(),
                activeColor: Colors.green,
              ),
              const SizedBox(width: 8),
              ResetButton(
                notifiers: resettableNotifiers,
              ),
              const SizedBox(width: 8),
              _buildToggleButton(
                context: context,
                ref: ref,
                icon: const Icon(Icons.speed, size: 20),
                isVisible:
                    ref.watch(counterVisibilityStateProvider).isSpeedVisible,
                onPressed: () => ref
                    .read(counterVisibilityStateProvider.notifier)
                    .toggleSpeed(),
                activeColor: Colors
                    .red, // Or orange as per original icon color, let's stick to theme or contrast. Red is fine for "active" indicator or stick to Icon color.
                // Re-reading user request: "Speed maximum becomes red".
                // Icon color here: standard is fine. Let's use generic active color.
              ),
            ],
          ),
          leading:
              ThemeModeChangeButton(themeModeStateProvider: themeModeProvider),
        ),
        body: body,
      ),
    );
  }

  Widget _buildToggleButton({
    required BuildContext context,
    required WidgetRef ref,
    required Widget icon,
    required bool isVisible,
    required VoidCallback onPressed,
    Color? activeColor,
  }) {
    final theme = Theme.of(context);
    final color = isVisible
        ? (activeColor ?? theme.colorScheme.primary)
        : theme.disabledColor;

    return IconButton(
      onPressed: onPressed,
      icon: DefaultTextStyle.merge(
        style: TextStyle(color: color),
        child: icon,
      ),
      style: IconButton.styleFrom(
        foregroundColor: color,
      ),
    );
  }
}
