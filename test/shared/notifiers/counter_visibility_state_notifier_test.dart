import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_counter/shared/providers/providers.dart';

void main() {
  group('CounterVisibilityStateNotifier のテスト', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('初期状態は全て非表示（false）であること', () {
      final state = container.read(counterVisibilityStateProvider);
      expect(state.isPoisonVisible, false);
      expect(state.isSpeedVisible, false);
    });

    test('togglePoison で毒の表示非表示が切り替わること', () {
      final notifier = container.read(counterVisibilityStateProvider.notifier);

      // 初期値 false -> true
      notifier.togglePoison();
      expect(
          container.read(counterVisibilityStateProvider).isPoisonVisible, true);

      // true -> false
      notifier.togglePoison();
      expect(container.read(counterVisibilityStateProvider).isPoisonVisible,
          false);
    });

    test('toggleSpeed でSpeedの表示非表示が切り替わること', () {
      final notifier = container.read(counterVisibilityStateProvider.notifier);

      // 初期値 false -> true
      notifier.toggleSpeed();
      expect(
          container.read(counterVisibilityStateProvider).isSpeedVisible, true);

      // true -> false
      notifier.toggleSpeed();
      expect(
          container.read(counterVisibilityStateProvider).isSpeedVisible, false);
    });
  });
}
