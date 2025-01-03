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
  Widget _displayWidget(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        _buttonLayer(context, ref),
        // 下2つもlayerにしたい
        // 現状は表示位置等の問題で一緒に出来ず
        _displayPlayerLife(context, ref),
        _displayPlayerLifeChange(context, ref)
      ],
    );
  }

  // ボタンレイヤーに表示するものをまとめたWidget
  Widget _buttonLayer(BuildContext context, WidgetRef ref) {
    List<Widget> buttonList;
    // 右側プレイヤー設定の場合、ボタンの順番を逆にしておく
    if (playerPosition == PlayerPosition.right) {
      buttonList = [_rightButton(context, ref), _leftButton(context, ref)];
    } else {
      buttonList = [_leftButton(context, ref), _rightButton(context, ref)];
    }
    return Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: buttonList,
      ),
    );
  }

  Widget _leftButton(BuildContext context, WidgetRef ref) {
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

  Widget _rightButton(BuildContext context, WidgetRef ref) {
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

  Widget _displayPlayerLife(BuildContext context, WidgetRef ref) {
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

  Widget _displayPlayerLifeChange(BuildContext context, WidgetRef ref) {
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
    return _displayWidget(context, ref);
  }
}
