import 'package:flutter/material.dart';
import 'package:life_counter/shared/constants/constants.dart';
import 'package:life_counter/shared/utils/effect.dart';
import 'package:life_counter/shared/widgets/button/life_change_button/life_change_button.dart';

class LifeChangeButtonFlick extends LifeChangeButton {
  final int flickThreshold;
  final VoidCallback onFlickFunc;

  const LifeChangeButtonFlick({
    this.flickThreshold = flickThresholdForLifeChange,
    required this.onFlickFunc,
    required super.text,
    required super.onPressed,
    super.alignment,
    super.textColor,
    super.key,
  });

  @override
  Widget createButton(BuildContext context) {
    // startPositionがbuild()再描画された際に破棄されるのでフリック判定ができない
    // 今までは再描画されなかったから耐えてた
    // 直前のライフ変更タイマーとフリックのタイミングが被るとアウト
    Offset? startLocalPosition;
    Offset? startGlobalPosition;
    Offset? lastLocalPosition;
    Offset? lastGlobalPosition;

    return GestureDetector(
      onPanStart: (details) {
        startLocalPosition = details.localPosition;
        startGlobalPosition = details.globalPosition;
        lastLocalPosition = details.localPosition;
        lastGlobalPosition = details.globalPosition;
      },
      onPanUpdate: (details) {
        lastLocalPosition = details.localPosition;
        lastGlobalPosition = details.globalPosition;
      },
      onPanEnd: (details) {
        if (startLocalPosition != null && lastLocalPosition != null) {
          double distance = (lastLocalPosition! - startLocalPosition!).distance;
          if (distance > flickThreshold) {
            onFlickFunc();
            Feedback.forTap(context);
            // フリック成功時：スタート地点とゴール地点の両方でリップルを出す
            if (startGlobalPosition != null) {
              showRippleEffect(context, startGlobalPosition!);
            }
            if (lastGlobalPosition != null) {
              showRippleEffect(context, lastGlobalPosition!);
            }
          } else {
            onPressed();
            Feedback.forTap(context);
            // フリック失敗（タップ扱い）：スタート地点（＝タップ位置）のみ
            if (startGlobalPosition != null) {
              showRippleEffect(context, startGlobalPosition!);
            }
          }
        }
        startLocalPosition = null;
        startGlobalPosition = null;
        lastLocalPosition = null;
        lastGlobalPosition = null;
      },
      child: ElevatedButton(
        onPressed: () => {onPressed()},
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: buttonText(context),
      ),
    );
  }
}
