// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_counter/app/life_counter_app.dart';
import 'package:life_counter/shared/constants/constants.dart';

void main() {
  testWidgets('カウンターの増分スモークテスト', (WidgetTester tester) async {
    // アプリをビルドし、描画を完了させます。
    await tester.pumpWidget(const ProviderScope(child: LifeCounterApp()));
    await tester.pumpAndSettle();

    // 初期値 (20) を確認
    expect(find.text('$defaultLife'), findsWidgets);

    // '+' ボタン（テキスト '+'）をタップ
    final plusButton = find.text('+').first;
    await tester.tap(plusButton);
    // ライフ数値の変化を反映
    await tester.pump();

    // カウンターが増加したことを確認
    expect(find.text('${defaultLife + 1}'), findsOneWidget);

    // PlayerStateNotifier 内のタイマー (lifeChangeDisplayTimer) が保留状態だと
    // テストが失敗するため、時間を進めてタイマーを消化させます。
    await tester.pump(const Duration(seconds: lifeChangeDisplayTimer + 1));
  });
}
