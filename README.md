# life_counter

私用で使うライフカウンター作成用リポジトリ
Flutterの勉強も兼ねて作成中
- 自分で使いやすいライフカウンターの開発

## 開発環境
- テキストエディタ(筆者はVSCode使用)
- Flutter
- Android Studio

それぞれのセットアップは一般的なやり方で問題なし
このうち、FlutterはVSCodeの拡張機能からセットアップ可能
Android Studioはテスト用デバイスの管理に必要

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
mainへチェックアウトしてコマンドラインより```flutter build apk --release```を入力してリリースビルド実施  
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
