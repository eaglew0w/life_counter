import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:life_counter/features/home/home_screen.dart';
import 'package:life_counter/features/life_counter/2player/life_counter_2_player_flick.dart';

void main() {
  testWidgets('HomeScreen displays LifeCounter2PlayerFlick',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: HomeScreen(),
        ),
      ),
    );

    expect(find.byType(LifeCounter2PlayerFlick), findsOneWidget);
  });
}
