import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_counter/models/background_state.dart';
import 'package:life_counter/notifiers/background_notifier.dart';
import 'package:life_counter/utils/global_functions.dart';

class BackgroundChangeButton extends ConsumerWidget {
  final NotifierProvider<BackgroundNotifier, BackgroundState>
      backgroundProvider;

  const BackgroundChangeButton({
    required this.backgroundProvider,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final BackgroundState backgroundState = ref.watch(backgroundProvider);
    final BackgroundNotifier backgroundNotifier =
        ref.read(backgroundProvider.notifier);
    return ElevatedButton(
      onPressed: () {
        backgroundNotifier.setNextBackground();
      },
      onLongPress: () {
        backgroundNotifier.reset();
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      child: getBackgroundIcon(
        (getNextBackground(backgroundState.background)),
      ),
    );
  }
}
