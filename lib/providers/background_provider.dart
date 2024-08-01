import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_counter/models/background_state.dart';

final backgroundProvider =
    StateProvider<BackgroundState>((ref) => BackgroundState.unset);
