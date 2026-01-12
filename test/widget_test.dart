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
import 'package:life_counter/shared/widgets/button/reset_button/reset_button.dart';
import 'package:life_counter/shared/widgets/button/theme_mode_change_button/theme_mode_change_button.dart';

void main() {
  testWidgets('アプリケーション統合スモークテスト', (WidgetTester tester) async {
    // アプリをビルド
    await tester.pumpWidget(const ProviderScope(child: LifeCounterApp()));
    await tester.pumpAndSettle();

    // 1. 初期表示の確認
    expect(find.text('$defaultLife'), findsWidgets);

    // 2. ライフの増減テスト (Player 1)
    final plusButton = find.text('+').first;
    final minusButton = find.text('-').first;

    await tester.tap(plusButton);
    await tester.pump();
    expect(find.text('${defaultLife + 1}'), findsOneWidget);
    expect(find.text('+1'), findsOneWidget);

    await tester.tap(minusButton);
    await tester.tap(minusButton);
    await tester.pump();
    // +1 - 1 - 1 = -1 -> 20 - 1 = 19
    expect(find.text('${defaultLife - 1}'), findsOneWidget);
    expect(find.text('-1'), findsOneWidget);

    // 3. テーマ変更テスト
    // leading にある ThemeModeChangeButton を探す
    final themeButton = find.byType(ThemeModeChangeButton);
    await tester.tap(themeButton);
    await tester.pumpAndSettle();

    // 4. リセットテスト
    // title にある ResetButton を長押し
    final resetButton = find.byType(ResetButton);
    await tester.longPress(resetButton);
    await tester.pumpAndSettle();

    // 全てが初期状態に戻っていることを確認
    expect(find.text('$defaultLife'), findsWidgets);
    expect(find.text('+1'), findsNothing);
    expect(find.text('-1'), findsNothing);
  });
}
