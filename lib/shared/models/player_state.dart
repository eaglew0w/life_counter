class PlayerState {
  int life;
  int lifeChange;

  PlayerState({required this.life, this.lifeChange = 0});

  PlayerState copyWith({int? life, int? lifeChange}) {
    return PlayerState(
        life: life ?? this.life, lifeChange: lifeChange ?? this.lifeChange);
  }
}
