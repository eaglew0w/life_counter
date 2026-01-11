import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_counter/shared/widgets/button/reset_button/reset_button.dart';
import 'package:life_counter/shared/widgets/button/theme_mode_change_button/theme_mode_change_button.dart';
import 'package:life_counter/shared/notifiers/resettable_notifier.dart';
import 'package:life_counter/shared/notifiers/theme_mode_state_notifier.dart';
import 'package:life_counter/shared/models/theme_mode_state.dart';

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
          title: ResetButton(
            notifiers: resettableNotifiers,
          ),
          leading:
              ThemeModeChangeButton(themeModeStateProvider: themeModeProvider),
        ),
        body: body,
      ),
    );
  }
}
