import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_counter/shared/models/theme_mode_state.dart';
import 'package:life_counter/shared/notifiers/theme_mode_state_notifier.dart';
import 'package:life_counter/shared/utils/global_functions.dart';

class ThemeModeChangeButton extends ConsumerWidget {
  final NotifierProvider<ThemeModeStateNotifier, ThemeModeState>
      themeModeStateProvider;

  const ThemeModeChangeButton({
    required this.themeModeStateProvider,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeModeState themeModeState = ref.watch(themeModeStateProvider);
    final ThemeModeStateNotifier themeModeStateNotifier =
        ref.read(themeModeStateProvider.notifier);
    return ElevatedButton(
      onPressed: () {
        themeModeStateNotifier.setNextThemeMode();
      },
      onLongPress: () {
        themeModeStateNotifier.reset();
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      child: getThemeModeIcon(themeModeState),
    );
  }
}
