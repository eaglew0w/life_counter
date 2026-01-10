import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_counter/shared/constants/constants.dart';
import 'package:life_counter/shared/providers/providers.dart';
import 'package:fake_async/fake_async.dart';

void main() {
  group('PlayerStateNotifier のテスト', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('初期ライフが defaultLife であること', () {
      final state = container.read(playerProviderList[0]);
      expect(state.life, defaultLife);
    });

    test('changeLife でライフと変更値が更新されること', () {
      final notifier = container.read(playerProviderList[0].notifier);

      notifier.changeLife(1);

      final state = container.read(playerProviderList[0]);
      expect(state.life, defaultLife + 1);
      expect(state.lifeChange, 1);
    });

    test('一定時間（タイマー）経過後に lifeChange が 0 にリセットされること', () {
      fakeAsync((async) {
        final notifier = container.read(playerProviderList[0].notifier);

        notifier.changeLife(1);
        expect(container.read(playerProviderList[0]).lifeChange, 1);

        // 規定時間（秒）進める
        async.elapse(const Duration(seconds: lifeChangeDisplayTimer));

        expect(container.read(playerProviderList[0]).lifeChange, 0);
      });
    });

    test('reset でライフが初期値に戻り、変更値がキャンセルされること', () {
      final notifier = container.read(playerProviderList[0].notifier);

      notifier.changeLife(5);
      expect(container.read(playerProviderList[0]).life, defaultLife + 5);

      notifier.reset();

      expect(container.read(playerProviderList[0]).life, defaultLife);
      expect(container.read(playerProviderList[0]).lifeChange, 0);
    });
  });
}
