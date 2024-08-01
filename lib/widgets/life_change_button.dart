import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/global_functions.dart';
import '../providers/life_notifier.dart';

class LifeChangeButton extends ConsumerWidget {
  final LifeNotifier lifeNotifier;
  final int changeValue;

  const LifeChangeButton({
    required this.lifeNotifier,
    required this.changeValue,
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
      child: Text(
        buttonText,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
