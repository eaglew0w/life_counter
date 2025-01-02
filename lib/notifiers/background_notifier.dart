import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_counter/constants/constants.dart';
import 'package:life_counter/utils/global_functions.dart';
import 'package:life_counter/models/background_state.dart';
import 'package:life_counter/notifiers/resettable_notifier.dart';

class BackgroundNotifier extends Notifier<BackgroundState>
    implements ResettableNotifier {
  @override
  BackgroundState build() {
    return BackgroundState(background: defaultBackground);
  }

  void setNextBackground() {
    state = BackgroundState(background: getNextBackground(state.background));
  }

  @override
  void reset() {
    state = BackgroundState(background: defaultBackground);
  }
}
