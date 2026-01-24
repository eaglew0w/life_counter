import 'package:life_counter/shared/constants/constants.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'timer_state.freezed.dart';

enum TimerMode {
  countDown50,
  countUp,
}

@freezed
class TimerState with _$TimerState {
  const factory TimerState({
    @Default(false) bool isEnabled,
    @Default(TimerMode.countDown50) TimerMode mode,
    @Default(Duration(minutes: defaultTimerDurationMinutes)) Duration duration,
    @Default(false) bool isRunning,
  }) = _TimerState;
}
