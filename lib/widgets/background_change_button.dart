import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_counter/models/background_state.dart';
import 'package:life_counter/utils/global_functions.dart';

class BackgroundChangeButton extends ConsumerWidget {
  final StateProvider<BackgroundState> backgroundProvider;

  const BackgroundChangeButton({
    required this.backgroundProvider,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () {
        ref.read(backgroundProvider.notifier).state =
            getNextBackground(ref.read(backgroundProvider.notifier).state);
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      child: getBackgroundIcon(
          getNextBackground(ref.read(backgroundProvider.notifier).state)),
    );
  }
}
