import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import 'package:life_counter/models/player_state.dart';
import 'package:life_counter/constants/constants.dart';
import 'package:life_counter/notifiers/resettable_notifier.dart';

class PlayerStateNotifier extends Notifier<PlayerState>
    implements ResettableNotifier {
  @override
  PlayerState build() {
    ref.onDispose(() {
      state.timer?.cancel();
    });
    return PlayerState(life: defaultLife);
  }

  void changeLife(int value) {
    state = PlayerState(
      life: state.life + value,
      lifeChange: state.lifeChange + value,
      timer: state.timer,
    );
    _restartTimer();
  }

  @override
  void reset() {
    state.timer?.cancel();
    state = PlayerState(life: defaultLife);
  }

  void _restartTimer() {
    state.timer?.cancel();
    state.timer = Timer(const Duration(seconds: lifeChangeDisplayTimer), () {
      state = PlayerState(life: state.life, lifeChange: 0, timer: state.timer);
    });
  }
}
