# life_counter

私用で使うライフカウンター作成用リポジトリ
Flutterの勉強も兼ねて作成中
- 自分で使いやすいライフカウンターの開発

## 開発環境
エディタはVSCodeを想定
Flutterの開発環境構築はインターネットで適当にいい感じに(後で書く)
知り合いなら直接聞いてくれ

## 作業フロー
1. issueを発行する
作業内容を記載すること
2. 作業ブランチを切り出して作業
最新のdevelopから feature/issue-"issueの数字" と切り出す
例えば #23 に対する作業だったら feature/issue-23 と切り出せばOK 
3. 作業ブランチをpushして開発ブランチへのPR作成
2で作成したブランチをpushして、開発ブランチ(feature/develop)へのPRを作成する
4. PRが問題なければマージ

## リリース作業
1. feature/developからfeature/mainへのPR作成
リリースするissueについてこのタイミングでcloseする
PRに close #"閉じるissue番号" を記載すればマージ時に自動でissueがcloseされる
2. PRをマージ
3. リリースバイナリ作成
mainへチェックアウトしてコマンドラインより以下を入力してリリースビルド実施
```
flutter build apk --release
```
ビルド成果物の格納先が表示される
4. Code の ReleasesからDraft a new releaseを押してリリース作成
Choose a tagでタグ付けをすること
3で作成したバイナリを含めること
文章自動生成でいい感じに文章作れるはず
Pubish releaseを押せば公開される
5. feature/developをmainから切り出して完了
手元でfeature/developにmainをコミットを作らずにマージしてpush


## ブランチ分け
- main
公開済みのブランチ。
- feature/develop
開発ブランチ。mainへマージして公開する。
- feature/issue-XX
作業ブランチ。feature/developへマージしてリリースへの準備をする。

## Getting Started
This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
