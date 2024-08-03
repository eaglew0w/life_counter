import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimerNotifier extends StateNotifier<Duration> {
  TimerNotifier() : super(Duration.zero);

  void startTimer() {
    state = Duration.zero;
    _startCounting();
  }

  void _startCounting() {
    final stopwatch = Stopwatch()..start();
    _tick(stopwatch);
  }

  void _tick(Stopwatch stopwatch) async {
    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      state = Duration(seconds: stopwatch.elapsed.inSeconds);
    }
  }
}

final timerProvider = StateNotifierProvider<TimerNotifier, Duration>((ref) {
  return TimerNotifier();
});
