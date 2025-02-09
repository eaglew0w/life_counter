import 'package:flutter/material.dart';

class LifeChangeButton extends StatelessWidget {
  final String text;
  final Alignment alignment;
  final Color? textColor;
  final VoidCallback onPressed;

  const LifeChangeButton({
    required this.text,
    required this.onPressed,
    this.alignment = Alignment.center,
    this.textColor,
    super.key,
  });

  // overrideしてボタン設定をする
  @protected
  Widget createButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => {onPressed()},
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      child: buttonText(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return createButton(context);
  }

  @protected
  Widget buttonText(BuildContext context) {
    final TextStyle? baseStyle = Theme.of(context).textTheme.headlineSmall;
    final TextStyle? textStyle =
        textColor != null ? baseStyle?.copyWith(color: textColor) : baseStyle;
    return Align(
      alignment: alignment,
      child: Text(text, style: textStyle),
    );
  }
}
