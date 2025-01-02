import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_counter/constants/constants.dart';
import 'package:life_counter/utils/global_functions.dart';
import 'package:life_counter/models/background_state.dart';
import 'package:life_counter/providers/resettable_notifier.dart';

class BackgroundNotifier extends StateNotifier<BackgroundState>
    implements ResettableNotifier {
  final Background defaultBackground;

  BackgroundNotifier(this.defaultBackground)
      : super(BackgroundState(background: defaultBackground));

  void setNextBackground() {
    state = BackgroundState(background: getNextBackground(state.background));
  }

  @override
  void reset() {
    state = BackgroundState(background: defaultBackground);
  }
}

final backgroundProvider =
    StateNotifierProvider<BackgroundNotifier, BackgroundState>(
        (ref) => BackgroundNotifier(defaultBackground));
