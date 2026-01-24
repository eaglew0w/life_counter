import 'package:flutter_test/flutter_test.dart';

import 'package:life_counter/shared/models/timer_state.dart';
import 'package:life_counter/shared/notifiers/timer_state_notifier.dart';

void main() {
  late TimerStateNotifier notifier;

  setUp(() {
    notifier = TimerStateNotifier();
  });

  tearDown(() {
    notifier.dispose();
  });

  test('Initial state is correct', () {
    expect(notifier.state.isEnabled, false);
    expect(notifier.state.mode, TimerMode.countDown50);
    expect(notifier.state.duration, const Duration(minutes: 50));
    expect(notifier.state.isRunning, false);
  });

  test('toggleEnabled true changes isEnabled and auto-starts', () {
    notifier.toggleEnabled(true);
    expect(notifier.state.isEnabled, true);
    expect(notifier.state.isRunning, true);

    notifier.toggleEnabled(false);
    expect(notifier.state.isEnabled, false);
    expect(notifier.state.isRunning, false);
  });

  test('toggleEnabled false resets state', () {
    notifier.toggleEnabled(true);
    // notifier.toggleTimer(); // Auto-starts now
    expect(notifier.state.isRunning, true);

    // 無効化された場合、停止してリセットされること
    notifier.toggleEnabled(false);
    expect(notifier.state.isEnabled, false);
    expect(notifier.state.isRunning, false);
    expect(notifier.state.duration, const Duration(minutes: 50));
  });

  test('setMode changes mode and resets duration', () {
    notifier.setMode(TimerMode.countUp);
    expect(notifier.state.mode, TimerMode.countUp);
    expect(notifier.state.duration, Duration.zero);

    notifier.setMode(TimerMode.countDown50);
    expect(notifier.state.mode, TimerMode.countDown50);
    expect(notifier.state.duration, const Duration(minutes: 50));
  });

  test('toggleTimer starts and stops timer logic', () async {
    // Note: Timer.periodicは非同期であり、FakeAsyncなしで完全にテストするのは難しいが、
    // 状態フラグを確認することはできる。

    // 開始
    notifier.toggleTimer();
    expect(notifier.state.isRunning, true);

    // 停止
    notifier.toggleTimer();
    expect(notifier.state.isRunning, false);
  });

  test('reset auto-starts timer if enabled', () {
    notifier.toggleEnabled(true);
    // notifier.toggleTimer(); // 自動スタート
    expect(notifier.state.isRunning, true);

    // 手動で停止
    notifier.toggleTimer();
    expect(notifier.state.isRunning, false);

    // リセットで再開されること
    notifier.reset();
    expect(notifier.state.isRunning, true);
    expect(notifier.state.duration, const Duration(minutes: 50));
  });

  test('reset does not auto-start timer if disabled', () {
    notifier.toggleEnabled(false);
    notifier.toggleTimer();
    // 無効化されている場合の挙動確認

    notifier.reset();
    expect(notifier.state.isRunning, false);
  });
}
