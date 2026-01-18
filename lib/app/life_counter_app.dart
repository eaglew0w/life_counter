import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_counter/features/home/home_screen.dart';
import 'package:life_counter/shared/constants/constants.dart';
import 'package:life_counter/shared/models/theme_mode_state.dart';
import 'package:life_counter/shared/providers/providers.dart';
import 'package:life_counter/shared/notifiers/pwa_update_state_notifier.dart';

import 'package:wakelock_plus/wakelock_plus.dart';

class LifeCounterApp extends ConsumerStatefulWidget {
  const LifeCounterApp({super.key});

  @override
  ConsumerState<LifeCounterApp> createState() => _LifeCounterAppState();
}

class _LifeCounterAppState extends ConsumerState<LifeCounterApp>
    with WidgetsBindingObserver {
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WakelockPlus.enable();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      WakelockPlus.enable();
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeModeState themeMode = ref.watch(themeModeStateProvider);

    ref.listen(
      pwaUpdateStateProvider,
      (previous, hasUpdate) {
        if (hasUpdate) {
          _scaffoldMessengerKey.currentState?.showSnackBar(
            SnackBar(
              content: const Text('新しいバージョンが利用可能です'),
              duration: const Duration(days: 1), // 永続表示に近い設定
              behavior: SnackBarBehavior.floating,
              action: SnackBarAction(
                label: '更新',
                onPressed: () {
                  ref.read(pwaUpdateStateProvider.notifier).reload();
                },
              ),
            ),
          );
        }
      },
    );

    return MaterialApp(
      scaffoldMessengerKey: _scaffoldMessengerKey,
      title: title,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode.themeMode,
      home: const HomeScreen(),
    );
  }
}
