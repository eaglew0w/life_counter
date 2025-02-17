import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_counter/features/home/home_screen.dart';
import 'package:life_counter/shared/constants/constants.dart';
import 'package:life_counter/shared/models/theme_mode_state.dart';
import 'package:life_counter/shared/providers/providers.dart';

class LifeCounterApp extends ConsumerWidget {
  const LifeCounterApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeModeState themeMode = ref.watch(themeModeStateProvider);
    return MaterialApp(
      title: title,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode.themeMode,
      home: const HomeScreen(),
    );
  }
}
