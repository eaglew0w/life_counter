import 'package:flutter/material.dart';

class LifeChangeButtonLongPress extends StatelessWidget {
  final String text;
  final Alignment alignment;
  final Color textColor;
  final VoidCallback onPressed;
  final VoidCallback onLongPress;

  const LifeChangeButtonLongPress({
    required this.text,
    required this.onPressed,
    required this.onLongPress,
    this.alignment = Alignment.center,
    this.textColor = Colors.white,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => {onPressed()},
      onLongPress: () => {onLongPress()},
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
    );
  }
}
