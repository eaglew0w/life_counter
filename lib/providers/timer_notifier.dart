import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_counter/providers/resettable_notifier.dart';

class TimerNotifier extends StateNotifier<Duration>
    implements ResettableNotifier {
  TimerNotifier()
      : stopwatch = Stopwatch(),
        super(Duration.zero) {
    reset();
  }

  // コンストラクタでタイマのインスタンス生成する
  final Stopwatch stopwatch;

  @override
  void reset() {
    // 表示をゼロにして時間計測開始
    // _tick()の中に入れても良さげ?
    state = Duration.zero;
    stopwatch.reset();
    stopwatch.start();
    // 過去に起動している_tick()のループを抜け出す処理は_tick()の中で行う
    _tick();
  }

  void _tick() async {
    Duration lastUpdateDuration = state;
    while (true) {
      state = Duration(seconds: stopwatch.elapsed.inSeconds);
      // 新しくtickを始めないと、resetした後ここのFuture.delayed()と同期が取れずに画面の更新タイミングがズレる
      // resetした段階でFuture.delayed()と同期を取れるなら単一のループを使いまわせる
      await Future.delayed(const Duration(seconds: 1));
      // stateがこの関数内で更新した値だった場合はstateを更新する
      // 違う場合(resetが呼ばれてstateが更新されたケース)はループ終了
      if (state == lastUpdateDuration) {
        Duration stopwatchDuration =
            Duration(seconds: stopwatch.elapsed.inSeconds);
        debugPrint('stopwatch = $stopwatchDuration');
        // resetを連打されたケースの場合、つまりstateと現在のstopwatchの値が一緒の場合はここでループ終了
        // stateと現在のstopwatchの値が一緒である場合
        // 一番最後に呼ばれた_tick()の中ではちょうど1秒ズレてこのif節には入らない
        if (state == stopwatchDuration) {
          debugPrint('reset連打ケース, $stopwatchDuration');
          break;
        } else {
          state = stopwatchDuration;
          lastUpdateDuration = state;
        }
      } else {
        debugPrint('reset呼ばれたので過去の更新ループ終了');
        break;
      }
    }
  }
}

final timerProvider = StateNotifierProvider<TimerNotifier, Duration>((ref) {
  return TimerNotifier();
});
