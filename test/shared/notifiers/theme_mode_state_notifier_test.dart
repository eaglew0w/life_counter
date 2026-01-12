import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:life_counter/shared/constants/constants.dart';
import 'package:life_counter/shared/providers/providers.dart';

void main() {
  group('ThemeModeStateNotifier のテスト', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('初期状態が initialThemeMode かつ isInitialMode が true であること', () {
      final state = container.read(themeModeStateProvider);
      expect(state.themeMode, initialThemeMode);
      expect(state.isInitialMode, isTrue);
    });

    test('setNextThemeMode でテーマが切り替わり isInitialMode が false になること', () {
      final notifier = container.read(themeModeStateProvider.notifier);

      // Dark -> Light (もしくはその逆) への遷移を確認
      // 初期値が ThemeMode.dark の場合を想定（constants.dartの実装に依存）
      final initialState = container.read(themeModeStateProvider);

      notifier.setNextThemeMode();

      final nextState = container.read(themeModeStateProvider);
      expect(nextState.themeMode, isNot(initialState.themeMode));
      expect(nextState.isInitialMode, isFalse);

      // もう一度切り替えて戻ることを確認
      notifier.setNextThemeMode();
      final backState = container.read(themeModeStateProvider);
      expect(backState.themeMode, initialState.themeMode);
      expect(backState.isInitialMode, isFalse);
    });

    test('reset で初期状態に戻ること', () {
      final notifier = container.read(themeModeStateProvider.notifier);

      notifier.setNextThemeMode();
      expect(container.read(themeModeStateProvider).isInitialMode, isFalse);

      notifier.reset();

      final state = container.read(themeModeStateProvider);
      expect(state.themeMode, initialThemeMode);
      expect(state.isInitialMode, isTrue);
    });
  });
}
