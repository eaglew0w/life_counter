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

void showRippleEffect(
  BuildContext context,
  Offset globalPosition, {
  Color? color,
}) {
  final overlay = Overlay.of(context);
  final renderBox = context.findRenderObject() as RenderBox?;
  if (renderBox == null || !renderBox.hasSize) return;

  final buttonRect = renderBox.localToGlobal(Offset.zero) & renderBox.size;
  // ボタンのサイズ（対角線）に基づいて最大半径を計算し、隅々までカバーする
  final maxRadius =
      (Offset(buttonRect.width, buttonRect.height).distance) * 1.2;

  // リップルの中心となるローカル座標を計算
  final localPosition = globalPosition - buttonRect.topLeft;

  late OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) => Stack(
      children: [
        Positioned(
          left: buttonRect.left,
          top: buttonRect.top,
          width: buttonRect.width,
          height: buttonRect.height,
          child: IgnorePointer(
            child: ClipRect(
              child: _RippleEffect(
                position: localPosition,
                color: color ?? Theme.of(context).splashColor,
                maxRadius: maxRadius,
                onAnimationComplete: () {
                  overlayEntry.remove();
                },
              ),
            ),
          ),
        ),
      ],
    ),
  );

  overlay.insert(overlayEntry);
}

class _RippleEffect extends StatefulWidget {
  final Offset position;
  final Color color;
  final double maxRadius;
  final VoidCallback onAnimationComplete;

  const _RippleEffect({
    required this.position,
    required this.color,
    required this.maxRadius,
    required this.onAnimationComplete,
  });

  @override
  State<_RippleEffect> createState() => _RippleEffectState();
}

class _RippleEffectState extends State<_RippleEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this);

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _opacityAnimation = Tween<double>(begin: 0.5, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward().then((_) => widget.onAnimationComplete());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: widget.position.dx - widget.maxRadius,
          top: widget.position.dy - widget.maxRadius,
          width: widget.maxRadius * 2,
          height: widget.maxRadius * 2,
          child: IgnorePointer(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Opacity(
                  opacity: _opacityAnimation.value,
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.color,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
