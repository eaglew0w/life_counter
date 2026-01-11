# life_counter

私用で使うライフカウンター作成用リポジトリ。Flutterの学習を兼ねて開発しています。

## 🚀 はじめに

このプロジェクトは Flutter で開発されています。以下の手順に従って環境構築を行ってください。

### 1. 開発環境のセットアップ

以下のツールをインストールしてください。

- **Flutter SDK**: [公式サイト](https://docs.flutter.dev/get-started/install)の指示に従ってインストールしてください。
- **Antigravity**: 本プロジェクトの推奨開発環境（IDE）です。
  - AIエージェント機能が統合されており、対話形式で開発を進められます。
  - [Antigravity公式サイト](https://antigravity.google/download)からインストールしてください。
- **Android Studio**: Androidエミュレータの管理とビルドに必要です。
- **GitHub CLI (`gh`)**: PR作成やリリース作業で使用します。
- **Git**: バージョン管理に使用します。

### 2. Antigravity のセットアップ

1. **ソフトウェアの起動**: インストールした Antigravity を起動します。
2. **プロジェクトの読み込み**: このプロジェクトのディレクトリを開いてください。
3. **エージェントの有効化**: プロジェクトルートの `.agent/rules/` にあるルールを読み込み、AIエージェントによる開発支援が開始されます。

### 3. プロジェクトのセットアップ

依存関係の解決は Antigravity 上のターミナル、またはコマンドプロンプトで以下を実行します。

```bash
flutter pub get
```

> [!NOTE]
> プロジェクト内の `.vscode` フォルダは、Antigravity と完全な互換性があります。デバッグ設定（`launch.json`）などはそのまま利用可能です。

### 4. アプリの実行・デバッグ

Antigravity ではコマンドに加え、直感的な操作でアプリを実行できます。

#### モバイル（エミュレータ/実機）

- **UI操作**: 右上の「Run アプリのデバッグ実行」ボタンをクリック
- **キー操作**: `F5` を押下（デフォルトで Web 版が起動するように設定されています）
- **コマンド**: `flutter run`

#### Web（ブラウザ）

UIやレイアウトの調整には Web 版の実行が高速で便利です。

- **UI操作**: ターゲットデバイスで「Chrome」を選択して実行
- **コマンド**: `flutter run -d chrome`

---

## 🛠 開発フロー

開発は以下のステップで行います。

1. **Issueの発行**: [GitHub Issues](https://github.com/eaglew0w/life_counter/issues) で作業内容を記載したIssueを発行します。
2. **ブランチの作成**: `origin/feature/develop` から `feature/issue-[Issue番号]` という名前でブランチを切り出します。
3. **実装とコミット**: コミットメッセージは `type: #[Issue番号] 概要` の形式で記述してください（例: `feat: #121 READMEの改善`）。
4. **検証**: 提出前に必ず[品質保証](#品質保証)のステップを実行してください。
5. **PRの作成**: `feature/develop` ブランチに対してプルリクエストを作成します。

## 品質保証

コードをプッシュする前に、以下のコマンドがすべてパスすることを確認してください。

- `dart format .` : コードの自動フォーマット
- `flutter analyze` : 静的解析
- `flutter test` : ユニット/ウィジェットテストの実行

---

## 📦 リリース手順

1. **準備**: `feature/develop` からリリース用Issueの番号でブランチを作成し、`pubspec.yaml` のバージョンを更新します。
2. **developへの統合**: リリースブランチから `feature/develop` へPRを作成・マージします。
3. **メインリリース**: `feature/develop` から `main` へのPRを作成・マージします。
4. **タグ付けとビルド**:
   - `main` の最新コミットにバージョンタグ（例: `v1.1.0`）を付与します。
   - `flutter build apk --release --split-per-abi` でAPKを生成します。
5. **GitHub Release作成**: `gh release create` コマンドを使用して、作成したAPKファイルを添付して公開します。

詳細な手順は [.agent/rules/release.md](.agent/rules/release.md) を参照してください。

---

## 📄 ブランチ構成

- **main**: 公開リリース用ブランチ
- **feature/develop**: 開発の統合ブランチ
- **feature/issue-XX**: 各Issueごとの作業ブランチ

---

## 📚 学習リソース

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)
- [Flutter Documentation](https://docs.flutter.dev/)
