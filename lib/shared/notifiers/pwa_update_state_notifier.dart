import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_counter/shared/services/pwa_update_service.dart';

/// PWAのアップデート検知状態を管理するProvider
final pwaUpdateStateProvider =
    StateNotifierProvider<PwaUpdateStateNotifier, bool>((ref) {
  return PwaUpdateStateNotifier();
});

class PwaUpdateStateNotifier extends StateNotifier<bool> {
  PwaUpdateStateNotifier() : super(false) {
    _init();
  }

  void _init() {
    // JSからのコールバックを受け取り、stateをtrueにする
    PwaUpdateService.setUpdateCallback(() {
      state = true;
    });
  }

  /// 更新実行（リロード）
  void reload() {
    PwaUpdateService.reloadPwa();
  }
}
