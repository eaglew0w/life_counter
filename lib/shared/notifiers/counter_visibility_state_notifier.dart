import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_counter/shared/models/counter_visibility_state.dart';
import 'package:life_counter/shared/utils/app_logger.dart';

class CounterVisibilityStateNotifier extends Notifier<CounterVisibilityState> {
  @override
  CounterVisibilityState build() {
    AppLogger.d('CounterVisibilityStateNotifier build');
    return const CounterVisibilityState();
  }

  void togglePoison() {
    final newState = !state.isPoisonVisible;
    AppLogger.i('Poison visibility toggled to $newState');
    state = state.copyWith(isPoisonVisible: newState);
  }

  void toggleSpeed() {
    final newState = !state.isSpeedVisible;
    AppLogger.i('Speed visibility toggled to $newState');
    state = state.copyWith(isSpeedVisible: newState);
  }
}
