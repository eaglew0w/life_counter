import 'package:flutter/material.dart';
import 'package:life_counter/shared/notifiers/resettable_notifier.dart';

class ResetButton extends StatelessWidget {
  final List<ResettableNotifier> notifiers;

  const ResetButton({required this.notifiers, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: null, // 通常タップでは何もしない
      onLongPress: () {
        // 長押しでリセット（誤操作防止）
        for (var notifier in notifiers) {
          notifier.reset();
        }
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      child: const Icon(Icons.restart_alt),
    );
  }
}
