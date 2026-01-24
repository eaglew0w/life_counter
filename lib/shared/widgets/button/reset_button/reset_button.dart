import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_counter/shared/notifiers/resettable_notifier.dart';
import 'package:life_counter/shared/providers/providers.dart';
import 'package:life_counter/shared/constants/constants.dart';

class ResetButton extends ConsumerWidget {
  final List<ResettableNotifier> notifiers;
  final double? size;
  final bool showTimer;

  const ResetButton({
    required this.notifiers,
    this.size,
    this.showTimer = true,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerState = ref.watch(timerStateProvider);
    final shouldShowTimer = showTimer && timerState.isEnabled;

    return ElevatedButton(
      onPressed: shouldShowTimer
          ? () {
              ref.read(timerStateProvider.notifier).toggleTimer();
            }
          : null,
      onLongPress: () {
        // 長押しでリセット（誤操作防止）
        for (var notifier in notifiers) {
          notifier.reset();
        }
        if (timerState.isEnabled) {
          ref.read(timerStateProvider.notifier).reset();
        }
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      child: shouldShowTimer
          ? Text(
              _formatDuration(timerState.duration),
              style: TextStyle(
                fontSize: size != null
                    ? size! * timerDisplayFontSizeRatio
                    : timerDisplayDefaultFontSize,
                fontWeight: FontWeight.bold,
              ),
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.restart_alt, size: size),
                const Text(timerResetButtonLabel,
                    style: TextStyle(fontSize: timerHoldLabelFontSize)),
              ],
            ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60) +
        (duration.inHours * 60)); // 60分以上も分で表示したい場合
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
