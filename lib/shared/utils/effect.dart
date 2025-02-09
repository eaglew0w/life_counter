import 'package:flutter/material.dart';

// 指定したWidgetの上にエフェクトを表示
void showFlashEffect(BuildContext context,
    {Color color = Colors.white, int alpha = 50, int durationMs = 50}) {
  final overlay = Overlay.of(context);

  // Widgetの位置とサイズを取得
  final renderBox = context.findRenderObject() as RenderBox?;
  if (renderBox == null) return;

  final buttonRect = renderBox.localToGlobal(Offset.zero) & renderBox.size;

  final overlayEntry = OverlayEntry(
    builder: (context) => Stack(
      children: [
        Positioned(
          left: buttonRect.left,
          top: buttonRect.top,
          width: buttonRect.width,
          height: buttonRect.height,
          child: IgnorePointer(
            child: Container(
              decoration: BoxDecoration(
                color:
                    Theme.of(context).splashColor.withAlpha(alpha), // 半透明のエフェクト
                borderRadius: BorderRadius.circular(0), // ボタンの形に合わせる
              ),
            ),
          ),
        ),
      ],
    ),
  );

  overlay.insert(overlayEntry);
  Future.delayed(Duration(milliseconds: durationMs), () {
    overlayEntry.remove();
  });
}
