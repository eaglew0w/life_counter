import 'dart:async';
import 'package:flutter/material.dart';

class Player extends StatefulWidget {
  final int life;
  const Player({super.key, required this.life});

  @override
  State<Player> createState() => PlayerState();
}

// 1プレイヤーのウィジェット
// プレイヤーのリソース及び増減カウンタをここで用意する
// resetのみ外部に公開
class PlayerState extends State<Player> {
  // プレイヤーのリソース
  late int _life;

  int _lifeChange = 0;

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _life = widget.life;
    _lifeChange = 0;
  }

  void _gainLife(int value) {
    setState(() {
      _life += value;
      _lifeChange += value;
    });
    _restartTimer();
  }

  void _loseLife(int value) {
    _gainLife(-value);
  }

  // 外部から初期化する用
  void reset(int defaultlife) {
    setState(() => _life = defaultlife);
  }

  void _restartTimer() {
    _timer?.cancel();
    _timer = Timer(const Duration(seconds: 5), () {
      setState(() {
        _lifeChange = 0;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Row(
            // Cross方向へはここのプロパティで広げれるだけ広げるようにする
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Main方向へはここで広げられる限り広げる
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _gainLife(1),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                    shadowColor: Colors.transparent,
                  ),
                child: const Text('+1'),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _loseLife(1),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                    shadowColor: Colors.transparent,
                  ),
                  child: const Text('-1'),
                ),
              ),
            ],
          ),
        ),
        Center(
          child: Text(
            '$_life',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        Align(
          alignment: const Alignment(0, 0.2),
          child: Text(
            _lifeChange == 0
              ? ''
              : _lifeChange > 0
                ? '+$_lifeChange'
                : '$_lifeChange',
            textAlign: TextAlign.end,
          ))
      ],
    );
  }
}