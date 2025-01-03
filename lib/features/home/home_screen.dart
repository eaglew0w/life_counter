import 'package:flutter/material.dart';
import 'package:life_counter/features/life_counter/2player/life_counter_2_player_long_press.dart';
import 'package:life_counter/shared/constants/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const LifeCounter2PlayerLongPress(
      title: title,
    );
  }
}
