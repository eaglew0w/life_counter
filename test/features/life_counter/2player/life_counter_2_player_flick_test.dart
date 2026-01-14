import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:life_counter/features/life_counter/2player/life_counter_2_player_flick.dart';
import 'package:life_counter/shared/constants/constants.dart';

void main() {
  group('LifeCounter2PlayerFlick UI Tests', () {
    testWidgets('Initial state is correct (Life 40)',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LifeCounter2PlayerFlick(),
          ),
        ),
      );

      // 初期ライフ40が表示されていること (2プレイヤー合計ではなく、それぞれの初期ライフ)
      // 2Playerモードではデフォルトで40ライフ (EDH想定?) いや、constants.dartのdefaultLifeは20.
      // アプリの仕様を確認。
      // PlayerStateNotifierの初期値は defaultLife (20).
      // しかし、LifeCounter2PlayerFlickで特にoverrideしていないなら20のはず。
      // ただし、以前の修正でEDH用に40にしている可能性も？
      // constants.dartを見る限り defaultLife = 20.
      // よって20を確認する。

      expect(find.text('20'), findsNWidgets(2));
    });

    testWidgets('Tapping +/- buttons changes life',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LifeCounter2PlayerFlick(),
          ),
        ),
      );

      // Player 1 (Left) の + ボタン (+1)
      await tester.tap(find.text(lifeGainText).first);
      await tester.pump();

      // +5 (変更量)が表示されるのは少し後か？
      // PlayerStateNotifierの実装では即座にstate更新されるはず。
      // life: 21, lifeChange: 1
      expect(find.text('21'), findsOneWidget);
      expect(find.text('+1'), findsOneWidget);

      // Player 1 (Left) の - ボタン (-1)
      await tester.tap(find.text(lifeLoseText).first);
      await tester.pump();

      // life: 20, lifeChange: 0
      expect(find.text('20'), findsNWidgets(2)); // 両方20に戻る

      // Timer消化待ち
      await tester.pump(const Duration(seconds: 6));
    });

    testWidgets('Reset button resets life', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LifeCounter2PlayerFlick(),
          ),
        ),
      );

      // ライフを変更
      await tester.tap(find.text(lifeGainText).first);
      await tester.pump();
      expect(find.text('21'), findsOneWidget);

      // リセットボタンを長押し
      await tester.longPress(find.byIcon(Icons.restart_alt));
      await tester.pumpAndSettle();

      // ライフが戻っていること
      expect(find.text('20'), findsNWidgets(2));
    });
  });
}
