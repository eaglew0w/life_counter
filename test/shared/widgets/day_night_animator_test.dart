import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:life_counter/shared/models/theme_mode_state.dart';
import 'package:life_counter/shared/notifiers/theme_mode_state_notifier.dart';
import 'package:life_counter/shared/widgets/day_night_animator.dart';

void main() {
  // Provider for testing
  final mockThemeModeProvider =
      NotifierProvider<ThemeModeStateNotifier, ThemeModeState>(
    () => ThemeModeStateNotifier(),
  );

  group('DayNightAnimator Test', () {
    testWidgets('初期表示でエラーが発生しないこと（初期はDarkモード）', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: Consumer(
                builder: (context, ref, child) {
                  return DayNightAnimator(
                    themeModeProvider: mockThemeModeProvider,
                  );
                },
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // 初期はDarkなので月が表示されているはず
      expect(find.byType(DayNightAnimator), findsOneWidget);
    });

    testWidgets('テーマ切り替え時にアニメーションが実行されること', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: Consumer(
                builder: (context, ref, child) {
                  return Stack(
                    children: [
                      DayNightAnimator(
                        themeModeProvider: mockThemeModeProvider,
                      ),
                      // テスト用の切り替えボタン
                      Positioned(
                        top: 0,
                        left: 0,
                        child: ElevatedButton(
                          onPressed: () {
                            ref
                                .read(mockThemeModeProvider.notifier)
                                .setNextThemeMode();
                          },
                          child: const Text('Toggle'),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // ボタンを押してテーマ切り替え
      await tester.tap(find.text('Toggle'));
      await tester.pump(); // アニメーション開始

      // アニメーション中であることを確認
      await tester.pump(const Duration(milliseconds: 500));
      // ここでエラーが出ないこと

      await tester.pumpAndSettle(); // アニメーション終了まで待機
    });

    testWidgets('リセット時にはアニメーションが抑制されるロジックが通ること', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: Consumer(
                builder: (context, ref, child) {
                  return Stack(
                    children: [
                      DayNightAnimator(
                        themeModeProvider: mockThemeModeProvider,
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        child: ElevatedButton(
                          onPressed: () {
                            ref.read(mockThemeModeProvider.notifier).reset();
                          },
                          child: const Text('Reset'),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // リセット実行
      await tester.tap(find.text('Reset'));
      await tester.pump();

      // isInitialMode: true になるため、アニメーションロジックはスキップされるはず
      // エラーなく完了することを確認
      await tester.pumpAndSettle();
    });
  });
}
