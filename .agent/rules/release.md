---
description: mainリリース（developからmainへのマージとリリース成果物の作成）の手順
trigger: always_on
---

# mainリリース手順

このドキュメントは、エージェントがプロジェクトのメインリリースを一貫した品質で実行するための指示書です。

## 1. 事前準備
1.  **Issueの発行**: GitHubでリリース用Issueを作成すること。
    - タイトル: `v[バージョン]リリース`
2.  **リリースブランチの作成**: `origin/develop` から `feature/issue-[Issue番号]` を作成すること。
3.  **バージョンの更新**: `pubspec.yaml` の `version` を更新すること（例: `1.1.0+1`）。
4.  **品質検証**: 以下のコマンドがすべてパスすることを確認すること。
    - `dart format .` 
    - `flutter analyze` 
    - `flutter test` 

## 2. 開発環境への合流 (develop)
1.  **PR作成**: `feature/issue-[Issue番号]` から `develop` へのプルリクエストを作成すること。
2.  **マージ**: PRが承認されたらマージしてブランチを削除すること。

## 3. 本番環境へのリリース (main)
1.  **リリースPR作成**: `develop` から `main` へのプルリクエストを作成すること。
2.  **マージ**: PRが承認されたらマージすること。
3.  **タグ付け**: `main` ブランチの最新コミットにバージョンのタグ（例: `v1.1.0`）を付与し、リモートへプッシュすること。

## 4. リリース成果物の作成 (Android)
1.  **ビルド**: `flutter build apk --release --split-per-abi` を実行すること。

## 5. GitHub Releases の作成
1.  **リリース作成**: `gh release create` を実行し、生成されたAPKファイルを添付すること。
    - コマンド例: `gh release create v[バージョン] build\app\outputs\flutter-apk\*.apk --title "v[バージョン]" --notes "リリースの概要""

## 6. Issueのクローズ
1.  **関連Issueの特定**: 前回のタグから今回のマージまでに対象ブランチに含まれたIssueをすべて特定すること。
2.  **一括処理**: `gh issue close [Issue番号...]` を実行して、含まれるすべてのIssueをクローズすること。

## 7. 後処理
1.  ローカルの `main` および `develop` を最新の状態に更新（fetch/pull）すること。
