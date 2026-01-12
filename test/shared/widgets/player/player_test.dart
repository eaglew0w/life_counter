import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:life_counter/shared/constants/constants.dart';
import 'package:life_counter/shared/models/player_state.dart';
import 'package:life_counter/shared/notifiers/player_state_notifier.dart';
import 'package:life_counter/shared/widgets/player/player.dart';

void main() {
  group('Player ウィジェットのテスト', () {
    testWidgets('ライフ数値と変更値が正しく表示されること', (WidgetTester tester) async {
      final container = ProviderContainer();
      final provider = NotifierProvider<PlayerStateNotifier, PlayerState>(
        () => PlayerStateNotifier(),
      );

      // 初期状態の確認
      expect(container.read(provider).life, defaultLife);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            home: Scaffold(
              body: Player(
                playerProvider: provider,
                loseButton: const Text('Lose'),
                gainButton: const Text('Gain'),
              ),
            ),
          ),
        ),
      );

      // 初期ライフが表示されていることを確認
      expect(find.text('$defaultLife'), findsOneWidget);

      // ライフを変更
      container.read(provider.notifier).changeLife(5);
      await tester.pump();

      // 新しいライフと変更値が表示されていることを確認
      expect(find.text('${defaultLife + 5}'), findsOneWidget);
      expect(find.text('+5'), findsOneWidget);

      // ライフを減らす
      container.read(provider.notifier).changeLife(-3);
      await tester.pump();

      // 変更値が合算されていることを確認 (+5 - 3 = +2)
      expect(find.text('${defaultLife + 2}'), findsOneWidget);
      expect(find.text('+2'), findsOneWidget);

      // タイマーを消化させる
      await tester.pump(const Duration(seconds: lifeChangeDisplayTimer + 1));
    });
  });
}
