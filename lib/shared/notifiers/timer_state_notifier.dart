import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_counter/shared/constants/constants.dart';
import 'package:life_counter/shared/models/timer_state.dart';
import 'package:life_counter/shared/notifiers/resettable_notifier.dart';

class TimerStateNotifier extends StateNotifier<TimerState>
    implements ResettableNotifier {
  Timer? _timer;
  final Duration _tick = const Duration(seconds: 1);

  TimerStateNotifier() : super(const TimerState());

  @override
  void reset() {
    _stopTimer();
    _resetDuration();
    if (state.isEnabled) {
      _startTimer();
    }
  }

  void toggleEnabled(bool value) {
    state = state.copyWith(isEnabled: value);
    reset();
  }

  void setMode(TimerMode mode) {
    if (state.mode == mode) return;
    state = state.copyWith(mode: mode);
    reset();
  }

  void toggleTimer() {
    if (state.isRunning) {
      _stopTimer();
    } else {
      _startTimer();
    }
  }

  void _startTimer() {
    if (state.isRunning) return;

    // カウントダウン終了時は開始しない
    if (state.mode == TimerMode.countDown50 && state.duration.inSeconds <= 0) {
      return;
    }

    state = state.copyWith(isRunning: true);
    _timer = Timer.periodic(_tick, (timer) {
      if (state.mode == TimerMode.countDown50) {
        final newDuration = state.duration - _tick;
        if (newDuration.inSeconds <= 0) {
          state = state.copyWith(duration: Duration.zero, isRunning: false);
          _stopTimer();
        } else {
          state = state.copyWith(duration: newDuration);
        }
      } else {
        // カウントアップ
        state = state.copyWith(duration: state.duration + _tick);
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
    if (mounted) {
      state = state.copyWith(isRunning: false);
    }
  }

  void _resetDuration() {
    if (state.mode == TimerMode.countDown50) {
      state = state.copyWith(
          duration: const Duration(minutes: defaultTimerDurationMinutes));
    } else {
      state = state.copyWith(duration: Duration.zero);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
