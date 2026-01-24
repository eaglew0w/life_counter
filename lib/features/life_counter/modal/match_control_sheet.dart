import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_counter/shared/constants/constants.dart';
import 'package:life_counter/shared/notifiers/pwa_update_state_notifier.dart';
import 'package:life_counter/shared/notifiers/resettable_notifier.dart';
import 'package:life_counter/shared/providers/providers.dart';
import 'package:life_counter/shared/widgets/button/reset_button/reset_button.dart';
import 'package:life_counter/shared/models/timer_state.dart';

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

              // ライフリセットボタン (メニュー中央に配置)
              Center(
                child: ResetButton(
                  notifiers: resettableNotifiers,
                  size: menuResetButtonSize, // メニュー用サイズ
                  showTimer: false, // メニューでは常にリセットを表示
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

              // 毒カウンター切り替え
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

              // 速度カウンター切り替え
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

              const Text(timerSectionTitle,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),

              // タイマー切り替え
              Consumer(
                builder: (context, ref, child) {
                  final timerState = ref.watch(timerStateProvider);
                  return Column(
                    children: [
                      SwitchListTile(
                        title: const Text(timerToggleLabel),
                        secondary: const Icon(Icons.timer),
                        value: timerState.isEnabled,
                        onChanged: (value) {
                          ref
                              .read(timerStateProvider.notifier)
                              .toggleEnabled(value);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            const Text(timerModeLabel),
                            const SizedBox(width: 8),
                            DropdownButton<TimerMode>(
                              value: timerState.mode,
                              onChanged: (TimerMode? newValue) {
                                if (newValue != null) {
                                  ref
                                      .read(timerStateProvider.notifier)
                                      .setMode(newValue);
                                }
                              },
                              items: const [
                                DropdownMenuItem(
                                  value: TimerMode.countDown50,
                                  child: Text(timerMode50min),
                                ),
                                DropdownMenuItem(
                                  value: TimerMode.countUp,
                                  child: Text(timerModeCountUp),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),

              const Divider(height: 32),

              // 更新確認ボタン
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
