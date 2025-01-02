import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_counter/models/background_state.dart';
import 'package:life_counter/notifiers/resettable_notifier.dart';
import 'package:life_counter/utils/global_functions.dart';
import 'package:life_counter/constants/constants.dart';
import 'package:life_counter/providers/providers.dart';
import 'package:life_counter/widgets/background_change_button.dart';
import 'package:life_counter/widgets/player.dart';
import 'package:life_counter/widgets/reset_button.dart';

class LifeCounter2Player extends ConsumerWidget {
  const LifeCounter2Player(
      {super.key,
      required this.title,
      required this.player1,
      required this.player2});

  final String title;
  final Player player1;
  final Player player2;

  List<ResettableNotifier> _resettableNotifierList(WidgetRef ref) {
    return [
      // 画面遷移時にプレイヤー3、4もリセットしてある状態にする
      ref.read(playerProviderList[Players.player1.index].notifier),
      ref.read(playerProviderList[Players.player2.index].notifier),
      ref.read(playerProviderList[Players.player3.index].notifier),
      ref.read(playerProviderList[Players.player4.index].notifier),
      ref.read(backgroundProvider.notifier)
    ];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final BackgroundState backgroundState = ref.watch(backgroundProvider);
    final Color backgroundColor =
        getBackgroundColor(backgroundState.background);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text(
          title,
          style: const TextStyle(color: textColorDefault),
        ),
        leading: ResetButton(
          notifiers: _resettableNotifierList(ref),
        ),
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
                  child: player1,
                ),
                Expanded(
                  child: player2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
