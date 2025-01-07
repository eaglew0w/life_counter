import 'package:flutter/material.dart';
import 'package:life_counter/shared/widgets/button/life_change_button/life_change_button.dart';

class LifeChangeButtonLongPress extends LifeChangeButton {
  final VoidCallback onLongPress;
  final Color splashColor;
  final Color highlightColor;
  const LifeChangeButtonLongPress({
    required this.onLongPress,
    required super.text,
    required super.onPressed,
    this.splashColor = Colors.transparent,
    this.highlightColor = Colors.transparent,
    super.alignment,
    super.textColor,
    super.key,
  });

  @override
  Widget createButton(BuildContext context) {
    return InkWell(
      onTap: () => {onPressed()},
      onLongPress: () => {
        onLongPress(),
        // 長押し判定OK時にもタップ音だけ鳴らす
        Feedback.forTap(context)
      },
      splashColor: splashColor,
      highlightColor: highlightColor,
      borderRadius: BorderRadius.circular(0),
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
