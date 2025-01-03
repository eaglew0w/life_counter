import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_counter/shared/models/background_state.dart';
import 'package:life_counter/shared/models/player_state.dart';
import 'package:life_counter/shared/notifiers/player_state_notifier.dart';
import 'package:life_counter/shared/notifiers/resettable_notifier.dart';
import 'package:life_counter/shared/utils/global_functions.dart';
import 'package:life_counter/shared/constants/constants.dart';
import 'package:life_counter/shared/providers/providers.dart';
import 'package:life_counter/shared/widgets/button/background_change_button/background_change_button.dart';
import 'package:life_counter/shared/widgets/player/player.dart';
import 'package:life_counter/shared/widgets/button/reset_button/reset_button.dart';

class LifeCounterBaseScreen extends ConsumerWidget {
  const LifeCounterBaseScreen({super.key, required this.title});

  final String title;

  // overrideして使用するプレイヤー表示を変更する
  Player _createPlayer(
      NotifierProvider<PlayerStateNotifier, PlayerState> playerProvider,
      PlayerPosition playerPosition) {
    return Player(
        playerProvider: playerProvider, playerPosition: playerPosition);
  }

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
                  child: _createPlayer(
                      playerProviderList[Players.player1.index],
                      PlayerPosition.left),
                ),
                Expanded(
                  child: _createPlayer(
                      playerProviderList[Players.player2.index],
                      PlayerPosition.right),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
