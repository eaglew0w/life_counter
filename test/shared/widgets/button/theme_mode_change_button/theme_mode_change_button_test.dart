import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:life_counter/shared/constants/constants.dart';
import 'package:life_counter/shared/models/theme_mode_state.dart';
import 'package:life_counter/shared/notifiers/theme_mode_state_notifier.dart';
import 'package:life_counter/shared/widgets/button/theme_mode_change_button/theme_mode_change_button.dart';

void main() {
  group('ThemeModeChangeButton のテスト', () {
    testWidgets('タップでテーマが切り替わること', (WidgetTester tester) async {
      final container = ProviderContainer();
      final provider = NotifierProvider<ThemeModeStateNotifier, ThemeModeState>(
        ThemeModeStateNotifier.new,
      );

      // 初期状態の確認 (デフォルトは Dark を想定)
      expect(container.read(provider).themeMode, initialThemeMode);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            home: Scaffold(
              body: ThemeModeChangeButton(themeModeStateProvider: provider),
            ),
          ),
        ),
      );

      // ボタンをタップ
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // テーマが切り替わっていることを確認
      expect(container.read(provider).themeMode, isNot(initialThemeMode));
      expect(container.read(provider).isInitialMode, isFalse);
    });

    testWidgets('長押しでリセットされること', (WidgetTester tester) async {
      final container = ProviderContainer();
      final provider = NotifierProvider<ThemeModeStateNotifier, ThemeModeState>(
        ThemeModeStateNotifier.new,
      );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            home: Scaffold(
              body: ThemeModeChangeButton(themeModeStateProvider: provider),
            ),
          ),
        ),
      );

      // まずタップして状態を変える
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      expect(container.read(provider).isInitialMode, isFalse);

      // 長押しでリセット
      await tester.longPress(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // 初期状態に戻っていることを確認
      expect(container.read(provider).themeMode, initialThemeMode);
      expect(container.read(provider).isInitialMode, isTrue);
    });
  });
}
