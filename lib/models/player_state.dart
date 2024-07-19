import 'dart:async';

class PlayerState {
  int life;
  int lifeChange;
  Timer? timer;

  PlayerState({required this.life, this.lifeChange = 0, this.timer});
}