import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_counter/shared/notifiers/player_state_notifier.dart';
import 'package:life_counter/shared/constants/constants.dart';
import 'package:life_counter/shared/providers/providers.dart';
import 'package:fake_async/fake_async.dart';

void main() {
  group('PlayerStateNotifier tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('Initial life should be defaultLife', () {
      final state = container.read(playerProviderList[0]);
      expect(state.life, defaultLife);
    });

    test('changeLife should update life and lifeChange', () {
      final notifier = container.read(playerProviderList[0].notifier);

      notifier.changeLife(1);

      final state = container.read(playerProviderList[0]);
      expect(state.life, defaultLife + 1);
      expect(state.lifeChange, 1);
    });

    test('lifeChange should reset to 0 after timer expires', () {
      fakeAsync((async) {
        final notifier = container.read(playerProviderList[0].notifier);

        notifier.changeLife(1);
        expect(container.read(playerProviderList[0]).lifeChange, 1);

        // 規定時間（秒）進める
        async.elapse(const Duration(seconds: lifeChangeDisplayTimer));

        expect(container.read(playerProviderList[0]).lifeChange, 0);
      });
    });

    test('reset should revert life to default and cancel lifeChange', () {
      final notifier = container.read(playerProviderList[0].notifier);

      notifier.changeLife(5);
      expect(container.read(playerProviderList[0]).life, defaultLife + 5);

      notifier.reset();

      expect(container.read(playerProviderList[0]).life, defaultLife);
      expect(container.read(playerProviderList[0]).lifeChange, 0);
    });
  });
}
