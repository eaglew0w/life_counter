import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_counter/shared/notifiers/theme_mode_notifier.dart';
import 'package:life_counter/shared/utils/global_functions.dart';

class ThemeModeChangeButton extends ConsumerWidget {
  final NotifierProvider<ThemeModeNotifier, ThemeMode> themeModeProvider;

  const ThemeModeChangeButton({
    required this.themeModeProvider,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeMode themeMode = ref.watch(themeModeProvider);
    final ThemeModeNotifier themeModeNotifier =
        ref.read(themeModeProvider.notifier);
    return ElevatedButton(
      onPressed: () {
        themeModeNotifier.setNextThemeMode();
      },
      onLongPress: () {
        themeModeNotifier.reset();
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      child: getThemeModeIcon(themeMode),
    );
  }
}
