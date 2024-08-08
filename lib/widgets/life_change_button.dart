import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_counter/utils/global_functions.dart';
import 'package:life_counter/providers/life_notifier.dart';

class LifeChangeButton extends ConsumerWidget {
  final LifeNotifier lifeNotifier;
  final int changeValue;
  final Alignment alignment;
  final Color textColor;

  const LifeChangeButton({
    required this.lifeNotifier,
    required this.changeValue,
    this.alignment = Alignment.center,
    this.textColor = Colors.white,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // late finalのフィールドを初期化するより先にbuildが呼ばれる場合エラーになるためbuildの中で表示するテキストを生成する
    final buttonText = addAbsoluteValueText(changeValue);

    return ElevatedButton(
      onPressed: () => lifeNotifier.gainLife(changeValue),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      child: Align(
        alignment: alignment,
        child: Text(
          buttonText,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}
