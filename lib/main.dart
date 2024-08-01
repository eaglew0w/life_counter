import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:life_counter/screens/life_counter_app.dart';

void main() {
  runApp(const ProviderScope(child: LifeCounterApp()));
  WakelockPlus.enable();
}
