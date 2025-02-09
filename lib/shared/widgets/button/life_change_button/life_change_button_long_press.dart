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
  Widget createButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => {onPressed()},
      onLongPress: () => {
        onLongPress(),
        // 長押し判定OK時にもタップ音だけ鳴らす
        Feedback.forTap(context)
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      child: buttonText(context),
    );
  }
}
