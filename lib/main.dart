import 'player.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const LifeCounterApp());
}

class LifeCounterApp extends StatelessWidget {
  const LifeCounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MTG Life Counter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LifeCounter(title: 'MTG Life Counter'),
    );
  }
}

class LifeCounter extends StatefulWidget {
  const LifeCounter({super.key, required this.title});

  final String title;

  @override
  State<LifeCounter> createState() => _LifeCounterState();
}

/*
  ライフカウンターのプレイヤーの配置レイアウトを決める
*/
class _LifeCounterState extends State<LifeCounter> {
  // 初期ライフの値
  final int _defaultLife = 20;

  // PlayerのGlobalKeyリスト
  final List<GlobalKey<PlayerState>> _playerGlobalKeyList = [];
  int _keyListIndex = 0;
  GlobalKey<PlayerState> _generateGlobalKey() {
    _playerGlobalKeyList.add(GlobalKey<PlayerState>());
    _keyListIndex++;
    return _playerGlobalKeyList[_keyListIndex - 1];
  }

  void _resetLife(int defaultLife) {
    setState(() {
      for (var key in _playerGlobalKeyList) {
        key.currentState?.reset(defaultLife);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          // 各項目の"高さ"をExpandedで均等に設定する
          Expanded(
            child: Row(
              children: [
                // 各項目の"幅"をExpandedで均等に設定する
                Expanded(
                  child: Player(key: _generateGlobalKey(), life: _defaultLife),
                ),
                ElevatedButton(
                  onPressed: () {
                    _resetLife(_defaultLife);
                  },
                  child: const Icon(Icons.handshake_outlined),
                ),
                Expanded(
                  child: Player(key: _generateGlobalKey(), life: _defaultLife),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}