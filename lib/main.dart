import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:life_counter/screens/life_counter_app_2player.dart';

void main() {
  runApp(const ProviderScope(child: LifeCounterApp2Player()));
  WakelockPlus.enable();
}
