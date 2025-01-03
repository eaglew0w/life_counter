import 'package:flutter/material.dart';
import 'package:life_counter/shared/widgets/button/life_change_button/life_change_button.dart';

class LifeChangeButtonFlick extends LifeChangeButton {
  final int flickThreshold;
  final VoidCallback onFlickFunc;
  final VoidCallback onTapFunc;

  const LifeChangeButtonFlick({
    required this.flickThreshold,
    required this.onFlickFunc,
    required this.onTapFunc,
    required super.text,
    required super.onPressed,
    super.alignment,
    super.textColor,
    super.key,
  });

  @override
  Widget createButton() {
    // startPositionがbuild()再描画された際に破棄されるのでフリック判定ができない
    // 今までは再描画されなかったから耐えてた
    // 直前のライフ変更タイマーとフリックのタイミングが被るとアウト
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
