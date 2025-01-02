import 'package:flutter/material.dart';

class LifeChangeButton extends StatelessWidget {
  final String text;
  final Alignment alignment;
  final Color textColor;
  final VoidCallback onPressed;

  const LifeChangeButton({
    required this.text,
    required this.onPressed,
    this.alignment = Alignment.center,
    this.textColor = Colors.white,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => {onPressed()},
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
