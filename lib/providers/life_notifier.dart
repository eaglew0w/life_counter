import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import 'package:life_counter/models/player_state.dart';
import 'package:life_counter/constants/constants.dart';

class LifeNotifier extends StateNotifier<PlayerState> {
  LifeNotifier(int initialLife) : super(PlayerState(life: initialLife));

  void gainLife(int value) {
    state = PlayerState(
      life: state.life + value,
      lifeChange: state.lifeChange + value,
      timer: state.timer,
    );
    _restartTimer();
  }

  void reset(int defaultLife) {
    state = PlayerState(life: defaultLife);
  }

  void _restartTimer() {
    state.timer?.cancel();
    state.timer = Timer(const Duration(seconds: lifeChangeDisplayTimer), () {
      state = PlayerState(life: state.life, lifeChange: 0, timer: state.timer);
    });
  }

  @override
  void dispose() {
    state.timer?.cancel();
    super.dispose();
  }
}

final player1Provider = StateNotifierProvider<LifeNotifier, PlayerState>(
    (ref) => LifeNotifier(defaultLife));
final player2Provider = StateNotifierProvider<LifeNotifier, PlayerState>(
    (ref) => LifeNotifier(defaultLife));
