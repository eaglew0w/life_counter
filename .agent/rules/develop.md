---
trigger: always_on
---

1. 新たにコード修正を行う場合、まずはgithubのissueを発行してください。
2. issueには作業内容の概要を記載してください。
3. 最新のorigin/feature/developからブランチを切り出してください。ブランチ名は `feature/issue-番号` としてください。
4. コミットメッセージは `type: #issue番号 概要` の形式で記述してください（例: `feat: #111 自動テストの導入`）。
5. コードを出力・編集する際は、以下のチェックを必ずローカルで実施し、パスすることを確認してください。
    - `dart format .` (プロジェクト全体のフォーマット適用)
    - `flutter analyze` (静的解析)
    - `flutter test` (全ユニット/ウィジェットテストの実行)
6. コード内のコメントは日本語で記述してください。
7. 作業完了してorigin/feature/developへマージする際には、元のブランチを削除しないでください。
8. origin/feature/developへマージした後は、fetchを行い、その後origin/feature/developにチェックアウトしてpullを行ってください。
