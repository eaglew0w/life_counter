import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_counter/shared/models/player_state.dart';
import 'package:life_counter/shared/notifiers/player_state_notifier.dart';
import 'package:life_counter/shared/notifiers/resettable_notifier.dart';
import 'package:life_counter/shared/constants/constants.dart';
import 'package:life_counter/shared/providers/providers.dart';
import 'package:life_counter/shared/widgets/button/theme_mode_change_button/theme_mode_change_button.dart';
import 'package:life_counter/shared/widgets/player/player.dart';
import 'package:life_counter/shared/widgets/button/reset_button/reset_button.dart';

class LifeCounterBaseScreen extends ConsumerWidget {
  const LifeCounterBaseScreen({super.key, required this.title});

  final String title;

  // overrideして使用するプレイヤー表示を変更する
  @protected
  Player createPlayer(
      NotifierProvider<PlayerStateNotifier, PlayerState> playerProvider,
      PlayerPosition playerPosition) {
    return Player(
        playerProvider: playerProvider, playerPosition: playerPosition);
  }

  @protected
  List<ResettableNotifier> resettableNotifierList(WidgetRef ref) {
    return [
      // 画面遷移時にプレイヤー3、4もリセットしてある状態にする
      ref.read(playerProviderList[Players.player1.index].notifier),
      ref.read(playerProviderList[Players.player2.index].notifier),
      ref.read(playerProviderList[Players.player3.index].notifier),
      ref.read(playerProviderList[Players.player4.index].notifier),
      ref.read(themeModeStateProvider.notifier)
    ];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopScope(
      canPop: false, // `false` にすると戻る操作を無効化
      // ログ埋め込みなどは別チケットで対応予定
      // 一旦コメントアウト
      // onPopInvokedWithResult: (didPop, result) {
      //   if (!didPop) {
      //     debugPrint("戻る操作がブロックされました！");
      //   } else {
      //     debugPrint("戻る操作が成功しました！ result: $result");
      //   }
      // },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            title,
          ),
          leading: ResetButton(
            notifiers: resettableNotifierList(ref),
          ),
          actions: [
            ThemeModeChangeButton(
                themeModeStateProvider: themeModeStateProvider),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: createPlayer(
                        playerProviderList[Players.player1.index],
                        PlayerPosition.left),
                  ),
                  Expanded(
                    child: createPlayer(
                        playerProviderList[Players.player2.index],
                        PlayerPosition.right),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
