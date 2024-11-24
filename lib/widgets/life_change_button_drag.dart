import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_counter/providers/life_notifier.dart';

class LifeChangeButtonDrag extends ConsumerWidget {
  final LifeNotifier lifeNotifier;
  final int changeValueOnTap;
  final int changeValueOnDrag;
  final Alignment alignment;
  final String textString;
  final Color textColor;

  const LifeChangeButtonDrag({
    required this.lifeNotifier,
    required this.textString,
    required this.changeValueOnTap,
    required this.changeValueOnDrag,
    this.alignment = Alignment.center,
    this.textColor = Colors.white,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => lifeNotifier.gainLife(changeValueOnTap),
      onVerticalDragEnd: (details) => lifeNotifier.gainLife(changeValueOnDrag),
      child: ElevatedButton(
        onPressed: null, // onPressedは使用せずGestureDetectorで操作
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: Align(
          alignment: alignment,
          child: Text(
            textString,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}
