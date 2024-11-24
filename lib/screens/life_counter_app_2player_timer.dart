import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_counter/models/background_state.dart';
import 'package:life_counter/providers/timer_notifier.dart';
import 'package:life_counter/utils/global_functions.dart';
import 'package:life_counter/providers/background_notifier.dart';
import 'package:life_counter/providers/life_notifier.dart';
import 'package:life_counter/widgets/background_change_button.dart';
import 'package:life_counter/widgets/player_addlifechange.dart';
import 'package:life_counter/widgets/reset_button.dart';

class LifeCounterApp2PlayerTimer extends StatelessWidget {
  const LifeCounterApp2PlayerTimer({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MTG Life Counter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LifeCounter(title: 'MTG Life Counter'),
    );
  }
}

class LifeCounter extends ConsumerWidget {
  const LifeCounter({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final BackgroundState backgroundState = ref.watch(backgroundProvider);
    final Color backgroundColor =
        getBackgroundColor(backgroundState.background);
    final duration = ref.watch(timerProvider);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Center(
          child: timerText(duration),
        ),
        leading: ResetButton(stateNotifiers: [
          // 画面遷移時にプレイヤー3、4もリセットしてある状態にする
          ref.read(player1Provider.notifier),
          ref.read(player2Provider.notifier),
          ref.read(player3Provider.notifier),
          ref.read(player4Provider.notifier),
          ref.read(backgroundProvider.notifier),
          ref.read(timerProvider.notifier)
        ]),
        actions: [
          BackgroundChangeButton(backgroundProvider: backgroundProvider),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: PlayerAddLifeChange(playerProvider: player1Provider),
                ),
                Expanded(
                  child: PlayerAddLifeChange(playerProvider: player2Provider),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
