import 'package:flutter/material.dart';

class LifeChangeButtonFlick extends StatelessWidget {
  final String text;
  final Alignment alignment;
  final Color textColor;
  final int flickThreshold;
  final VoidCallback onFlickFunc;
  final VoidCallback onTapFunc;

  const LifeChangeButtonFlick({
    required this.text,
    required this.flickThreshold,
    required this.onFlickFunc,
    required this.onTapFunc,
    this.alignment = Alignment.center,
    this.textColor = Colors.white,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Offset? startPosition;
    return GestureDetector(
      onPanStart: (details) {
        startPosition = details.localPosition;
      },
      onPanEnd: (details) {
        if (startPosition != null) {
          double distance = (details.localPosition - startPosition!).distance;
          if (distance > flickThreshold) {
            onFlickFunc();
          } else {
            onTapFunc();
          }
        }
        startPosition = null;
      },
      child: ElevatedButton(
        onPressed: () => {onTapFunc()},
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: Align(
          alignment: alignment,
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}
