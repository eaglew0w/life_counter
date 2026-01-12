import 'package:freezed_annotation/freezed_annotation.dart';

part 'player_state.freezed.dart';

@freezed
class PlayerState with _$PlayerState {
  const factory PlayerState({
    required int life,
    @Default(0) int lifeChange,
    @Default(0) int poison,
    @Default(0) int speed,
  }) = _PlayerState;
}
