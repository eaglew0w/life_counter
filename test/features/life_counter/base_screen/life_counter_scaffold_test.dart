import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:life_counter/features/life_counter/base_screen/life_counter_scaffold.dart';
import 'package:life_counter/shared/providers/providers.dart';

void main() {
  group('LifeCounterScaffold UI テスト', () {
    testWidgets('AppBarにメニューとリセットボタンが表示されること', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: LifeCounterScaffold(
              resettableNotifiers: const [],
              themeModeProvider: themeModeStateProvider,
              body: const Text('Body Content'),
            ),
          ),
        ),
      );

      // リセットボタンがタイトル (中央) にあること
      // ResetButtonはIcon(Icons.restart_alt)を含んでいる
      expect(find.byIcon(Icons.restart_alt), findsOneWidget);

      // メニューボタンがアクション (右側) にあること
      expect(find.byIcon(Icons.menu), findsOneWidget);

      // Bodyの内容
      expect(find.text('Body Content'), findsOneWidget);
    });


    testWidgets('メニューボタンをタップするとMatchControlSheetが開くこと', (WidgetTester tester) async {
       // テスト用に画面サイズを大きくしてオーバーフローを回避
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: LifeCounterScaffold(
              resettableNotifiers: const [],
              themeModeProvider: themeModeStateProvider,
              body: const Text('Body Content'),
            ),
          ),
        ),
      );

      // 初期状態: シートは表示されていない
      expect(find.text('Match Control'), findsNothing);

      // メニューボタンをタップ
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      // シートが表示されていること
      expect(find.text('Match Control'), findsOneWidget);
      expect(find.text('Life Reset'), findsOneWidget);
    });
  });
}
