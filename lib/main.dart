import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_counter/app/life_counter_app.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import 'package:life_counter/shared/utils/app_provider_observer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    BrowserContextMenu.disableContextMenu();
  }
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]).then((_) {
    runApp(
      ProviderScope(
        observers: [AppProviderObserver()],
        child: const LifeCounterApp(),
      ),
    );
    WakelockPlus.enable();
  });
}
