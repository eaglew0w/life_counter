import 'package:flutter/material.dart';
import 'package:life_counter/shared/widgets/button/life_change_button/life_change_button.dart';

class LifeChangeButtonLongPress extends LifeChangeButton {
  final VoidCallback onLongPress;

  const LifeChangeButtonLongPress({
    required this.onLongPress,
    required super.text,
    required super.onPressed,
    super.alignment,
    super.textColor,
    super.key,
  });

  @override
  Widget createButton() {
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
