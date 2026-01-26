import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:life_counter/features/life_counter/modal/match_control_sheet.dart';
import 'package:life_counter/shared/constants/constants.dart';
import 'package:life_counter/shared/notifiers/resettable_notifier.dart';

void main() {
  group('MatchControlSheet UI テスト', () {
    testWidgets('全てのコントロールが正しく表示されること', (WidgetTester tester) async {
      final resettableNotifiers = <ResettableNotifier>[];

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: MatchControlSheet(resettableNotifiers: resettableNotifiers),
            ),
          ),
        ),
      );

      // タイトルの確認
      expect(find.text(matchControlTitle), findsOneWidget);

      // リセットボタンの確認 (シート内)
      expect(find.text(lifeResetLabel), findsOneWidget);
      expect(find.byIcon(Icons.restart_alt), findsOneWidget);

      // 毒カウンターのトグルの確認
      expect(find.text(poisonCounterLabel), findsOneWidget);
      expect(find.byType(SwitchListTile), findsNWidgets(3)); // 毒 + 速度 + タイマー

      // 更新確認ボタンの確認
      expect(find.text(updateCheckLabel), findsOneWidget);
      expect(find.byIcon(Icons.refresh), findsOneWidget);
    });

    testWidgets('トグル操作でプロバイダーの状態が更新されること', (WidgetTester tester) async {
      final resettableNotifiers = <ResettableNotifier>[];

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: MatchControlSheet(resettableNotifiers: resettableNotifiers),
            ),
          ),
        ),
      );

      // 初期状態: 毒は非表示
      // スイッチがオフであることを確認 (value=false)
      final poisonSwitchFinder =
          find.widgetWithText(SwitchListTile, poisonCounterLabel);
      SwitchListTile poisonSwitch = tester.widget(poisonSwitchFinder);
      expect(poisonSwitch.value, isFalse);

      // タップして切り替え
      await tester.tap(poisonSwitchFinder);
      await tester.pump();

      // スイッチがオンになったことを確認
      poisonSwitch = tester.widget(poisonSwitchFinder);
      expect(poisonSwitch.value, isTrue);

      // 速度カウンターのトグル
      final speedSwitchFinder =
          find.widgetWithText(SwitchListTile, speedCounterLabel);
      SwitchListTile speedSwitch = tester.widget(speedSwitchFinder);
      expect(speedSwitch.value, isFalse);

      await tester.tap(speedSwitchFinder);
      await tester.pump();

      speedSwitch = tester.widget(speedSwitchFinder);
      expect(speedSwitch.value, isTrue);
    });
  });
}
