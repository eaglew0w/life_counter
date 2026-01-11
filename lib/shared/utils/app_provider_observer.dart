import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_counter/shared/utils/app_logger.dart';

/// Providerの状態変化を監視し、ログを出力するクラス
class AppProviderObserver extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    AppLogger.d('''
Provider Updated: [${provider.name ?? provider.runtimeType}]
  - Previous: $previousValue
  - Current : $newValue
''');
  }

  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) {
    AppLogger.d(
        'Provider Added: [${provider.name ?? provider.runtimeType}] with value: $value');
  }

  @override
  void didDisposeProvider(
    ProviderBase<Object?> provider,
    ProviderContainer container,
  ) {
    AppLogger.d(
        'Provider Disposed: [${provider.name ?? provider.runtimeType}]');
  }

  @override
  void providerDidFail(
    ProviderBase<Object?> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    AppLogger.e(
      'Provider Failed: [${provider.name ?? provider.runtimeType}]',
      error,
      stackTrace,
    );
  }
}
