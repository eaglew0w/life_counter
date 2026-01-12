import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:life_counter/shared/widgets/button/reset_button/reset_button.dart';
import 'package:life_counter/shared/notifiers/resettable_notifier.dart';

/// テスト用のモックNotifier
class MockResettableNotifier implements ResettableNotifier {
  bool wasReset = false;

  @override
  void reset() {
    wasReset = true;
  }
}

void main() {
  group('ResetButton のテスト', () {
    testWidgets('長押しでリセットが実行されること', (WidgetTester tester) async {
      final mockNotifier = MockResettableNotifier();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ResetButton(notifiers: [mockNotifier]),
          ),
        ),
      );

      // リセットボタンを長押し
      await tester.longPress(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // リセットが実行されたことを確認
      expect(mockNotifier.wasReset, isTrue);
    });

    testWidgets('通常タップではリセットが実行されないこと', (WidgetTester tester) async {
      final mockNotifier = MockResettableNotifier();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ResetButton(notifiers: [mockNotifier]),
          ),
        ),
      );

      // リセットボタンを通常タップ
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // リセットが実行されていないことを確認
      expect(mockNotifier.wasReset, isFalse);
    });
  });
}
