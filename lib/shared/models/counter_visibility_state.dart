import 'package:freezed_annotation/freezed_annotation.dart';

part 'counter_visibility_state.freezed.dart';

@freezed
class CounterVisibilityState with _$CounterVisibilityState {
  const factory CounterVisibilityState({
    @Default(false) bool isPoisonVisible,
    @Default(false) bool isSpeedVisible,
  }) = _CounterVisibilityState;
}
