import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'life_counter_app.dart';

void main() {
  runApp(const ProviderScope(child: LifeCounterApp()));
}