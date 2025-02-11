import 'dart:async';

class PlayerState {
  int life;
  int lifeChange;

  PlayerState({required this.life, this.lifeChange = 0});

  PlayerState copyWith(
      {int? life, int? lifeChange, Timer? timer}) {
    return PlayerState(
        life: life ?? this.life,
        lifeChange: lifeChange ?? this.lifeChange);
  }
}
