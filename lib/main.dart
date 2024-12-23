import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_counter/screens/life_counter_app_2player_long_press.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

void main() {
  runApp(const ProviderScope(child: LifeCounterApp2PlayerLongPress()));
  WakelockPlus.enable();
}
