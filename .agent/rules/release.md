---
description: mainリリース（developからmainへのマージとリリース成果物の作成）の手順
trigger: always_on
---

# mainリリース手順

このドキュメントは、エージェントがプロジェクトのメインリリースを一貫した品質で実行するための指示書です。

## 1. 事前準備
1.  **Issueの発行**: GitHubでリリース用Issueを作成すること。
    - タイトル: `v[バージョン]リリース`
2.  **リリース作業用ブランチの作成**: `origin/develop` から `feature/issue-[Issue番号]` を作成し、このブランチでリリース作業を行うこと。
3.  **バージョンの更新**: `pubspec.yaml` の `version` を更新すること（例: `1.1.0+1`）。
4.  **品質検証**: 以下のコマンドがすべてパスすることを確認すること。
    - `dart format .` 
    - `flutter analyze` 
    - `flutter test` 

## 2. 開発環境への合流 (develop)
1.  **PR作成**: `feature/issue-[Issue番号]` から `develop` へのプルリクエストを作成すること。
2.  **マージ**: PRが承認されたらマージしてブランチを削除すること。
    - **Note**: この時点ではまだリリースIssueをクローズしないこと。

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
1.  **リリースIssueのクローズ**: mainリリース完了後、本リリース作業用に作成したIssue（`v[バージョン]リリース`）をクローズすること。
2.  **確認**: 今回のリリースに含まれる機能のIssueが全てクローズされているか確認すること。

## 7. 後処理
1.  **developの同期**: リリース完了後、ローカルの `main` および `develop` を最新の状態に更新（fetch/pull）すること。
2.  **追従マージとプッシュ**: `origin/main` を fetch し、ローカルの `develop` へマージして `origin/develop` へプッシュすること（PR不要）。

## 8. Hotfixリリース (緊急修正)
通常のリリースフローとは異なり、緊急を要するバグ修正などを `main` ブランチに対して直接的に行う場合の手順です。

### 8.1. 事前準備
1.  **Issueの発行**: GitHubでIssueを作成すること。
    - タイトル: `Hotfix: [修正内容概要]`
2.  **ブランチ作成**: 最新の `origin/main` からブランチを切り出すこと。
    - ブランチ名形式: `hotfix/issue-[Issue番号]`
3.  **バージョンの更新**: `pubspec.yaml` の `version` を更新すること（Patchバージョンをインクリメント）。

### 8.2. 本番反映 (main)
1.  **PR作成**: `hotfix/issue-[Issue番号]` から `main` へのプルリクエストを作成すること。
2.  **品質検証**: CIチェック（`flutter analyze`, `flutter test` 等）がパスしていることを確認すること。
3.  **マージ**: PRが承認されたらマージすること。
4.  **タグ付け**: `main` ブランチの最新コミットにバージョンのタグ（例: `v1.5.1`）を付与し、リモートへプッシュすること。

### 8.3. リリース成果物 (Android)
1.  **ビルド**: 通常リリースと同様にAPKを作成すること。
2.  **リリース作成**: GitHub Releasesを作成し、APKを添付すること。

### 8.4. 開発環境への反映 (Backport)
Hotfixの内容を `develop` ブランチにも反映させる必要があります。`main` と `develop` の乖離を防ぐため、以下の手順で同期を行ってください。

1.  **マージ**: `origin/main` を fetch し、ローカルの `develop` ブランチに `origin/main` をマージする。
    - コマンド例:
      ```bash
      git fetch origin
      git checkout develop
      git merge origin/main
      ```
2.  **プッシュ**: マージ結果を `origin/develop` へプッシュする。
    - **Note**: PRは作成せず、直接プッシュして構いません。
