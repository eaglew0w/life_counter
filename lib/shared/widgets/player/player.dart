import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_counter/shared/constants/constants.dart';
import 'package:life_counter/shared/utils/global_functions.dart';
import 'package:life_counter/shared/models/player_state.dart';
import 'package:life_counter/shared/notifiers/player_state_notifier.dart';
import 'package:life_counter/shared/widgets/button/life_change_button/life_change_button.dart';

class Player extends ConsumerWidget {
  final NotifierProvider<PlayerStateNotifier, PlayerState> playerProvider;

  final PlayerPosition playerPosition;

  const Player(
      {required this.playerProvider,
      this.playerPosition = PlayerPosition.none,
      super.key});

  // レイヤーをStackでまとめて表示するWidget
  @protected
  Widget displayWidget(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        buttonLayer(context, ref),
        // 下2つもlayerにしたい
        // 現状は表示位置等の問題で一緒に出来ず
        displayPlayerLife(context, ref),
        displayPlayerLifeChange(context, ref)
      ],
    );
  }

  // ボタンレイヤーに表示するものをまとめたWidget
  @protected
  Widget buttonLayer(BuildContext context, WidgetRef ref) {
    List<Widget> buttonList;
    // 右側プレイヤー設定の場合、ボタンの順番を逆にしておく
    if (playerPosition == PlayerPosition.right) {
      buttonList = [rightButton(context, ref), leftButton(context, ref)];
    } else {
      buttonList = [leftButton(context, ref), rightButton(context, ref)];
    }
    return Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: buttonList,
      ),
    );
  }

  @protected
  Widget leftButton(BuildContext context, WidgetRef ref) {
    final PlayerStateNotifier playerStateNotifier =
        ref.read(playerProvider.notifier);
    return Expanded(
      child: LifeChangeButton(
        text: ChangeLifeInfo.loseText,
        onPressed: () =>
            playerStateNotifier.changeLife(ChangeLifeInfo.loseOnTap),
        textColor: lifeChangeButtonColor,
      ),
    );
  }

  @protected
  Widget rightButton(BuildContext context, WidgetRef ref) {
    final PlayerStateNotifier playerStateNotifier =
        ref.read(playerProvider.notifier);
    return Expanded(
      child: LifeChangeButton(
        text: ChangeLifeInfo.gainText,
        onPressed: () =>
            playerStateNotifier.changeLife(ChangeLifeInfo.gainOnTap),
        textColor: lifeChangeButtonColor,
      ),
    );
  }

  @protected
  Widget displayPlayerLife(BuildContext context, WidgetRef ref) {
    final PlayerState playerState = ref.watch(playerProvider);
    return Center(
      child: Text(
        '${playerState.life}',
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .displayLarge
            ?.copyWith(color: textColorDefault),
      ),
    );
  }

  @protected
  Widget displayPlayerLifeChange(BuildContext context, WidgetRef ref) {
    final PlayerState playerState = ref.watch(playerProvider);
    return Align(
      alignment: const Alignment(
          alignmentXofPlayerLifeChange, alignmentYofPlayerLifeChange),
      child: Text(
        addAbsoluteValueText(playerState.lifeChange),
        textAlign: TextAlign.end,
        style: const TextStyle(
          color: textColorDefault,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return displayWidget(context, ref);
  }
}
