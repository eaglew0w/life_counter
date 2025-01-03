import 'package:flutter/material.dart';
import 'package:life_counter/features/lifecounter2player/life_counter_2_player.dart';
import 'package:life_counter/shared/constants/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const LifeCounter2Player(
      title: title,
    );
  }
}
