import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import 'package:life_counter/shared/utils/app_logger.dart';
import 'package:life_counter/shared/models/player_state.dart';
import 'package:life_counter/shared/constants/constants.dart';
import 'package:life_counter/shared/notifiers/resettable_notifier.dart';

class PlayerStateNotifier extends Notifier<PlayerState>
    implements ResettableNotifier {
  Timer? _lifeChangeTimer;

  @override
  PlayerState build() {
    AppLogger.d('PlayerStateNotifier build');
    ref.onDispose(() {
      AppLogger.d('PlayerStateNotifier disposed');
    });
    return const PlayerState(life: defaultLife);
  }

  void changeLife(int value) {
    AppLogger.i('Life changed by $value (Current: ${state.life})');
    state = state.copyWith(
      life: state.life + value,
      lifeChange: state.lifeChange + value,
    );
    _restartTimer();
  }

  void changePoison(int value) {
    AppLogger.i('Poison changed by $value (Current: ${state.poison})');
    state = state.copyWith(poison: state.poison + value);
  }

  void resetPoison() {
    AppLogger.i('Poison reset');
    state = state.copyWith(poison: 0);
  }

  void changeSpeed(int value) {
    final newSpeed = (state.speed + value).clamp(0, 4);
    if (newSpeed != state.speed) {
      AppLogger.i('Speed changed to $newSpeed (Previous: ${state.speed})');
      state = state.copyWith(speed: newSpeed);
    }
  }

  void resetSpeed() {
    AppLogger.i('Speed reset');
    state = state.copyWith(speed: 0);
  }

  @override
  void reset() {
    AppLogger.i('Player state reset');
    _lifeChangeTimer?.cancel();
    state = const PlayerState(life: defaultLife);
  }

  void _restartTimer() {
    _lifeChangeTimer?.cancel();
    _lifeChangeTimer =
        Timer(const Duration(seconds: lifeChangeDisplayTimer), () {
      state = state.copyWith(lifeChange: 0);
    });
  }
}
