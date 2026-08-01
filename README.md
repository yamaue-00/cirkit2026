# TeamB研修プロジェクト 2025

## プロジェクト概要

このリポジトリは、3日間開催しているhackitの開発用に制作されたものです



## 技術スタック

- **言語**: Ruby 3.2.2
- **フレームワーク**: Ruby on Rails 8.0.2
- **データベース**: MySQL 8.4
- **コンテナ技術**: Docker & Docker Compose
- **フロントエンド**: Stimulus.js, Turbo, Importmap

## 前提条件

開発を始める前に、以下のソフトウェアがインストールされていることを確認してください：

- [Docker](https://docs.docker.com/get-docker/) (20.10.0以上)
- [Docker Compose](https://docs.docker.com/compose/install/) (2.0.0以上)
- [Git](https://git-scm.com/downloads)

## セットアップ手順

### 1. リポジトリのクローン

```bash
git clone git@github.com:yamaue-00/2026hackit.git
cd cirkit2026
```

### 2. Dockerコンテナの起動

```bash
# コンテナをビルドして起動
docker compose up --build

# または、バックグラウンドで実行する場合
docker compose up -d --build
```

### 3. データベースのセットアップ

別のターミナルで以下のコマンドを実行：

```bash
# データベースの作成
docker compose exec rails bundle exec rails db:create

# マイグレーションの実行
docker compose exec rails bundle exec rails db:migrate

# シードデータの投入（必要に応じて）
docker compose exec rails bundle exec rails db:seed
```

### 4. アプリケーションの確認

ブラウザで [http://localhost:3000](http://localhost:3000) にアクセスして、アプリケーションが正常に動作していることを確認してください。

## 開発コマンド

### よく使用するコマンド

```bash
# コンテナの起動
docker compose up

# コンテナの停止
docker compose down

# Railsコンソールの起動
docker compose exec rails bundle exec rails console

# テストの実行
docker compose exec rails bundle exec rails test

# ルートの確認
docker compose exec rails bundle exec rails routes

# Gemのインストール
docker compose exec rails bundle install

# 新しいマイグレーションの作成
docker compose exec rails bundle exec rails generate migration MigrationName

# マイグレーションの実行
docker compose exec rails bundle exec rails db:migrate
```

## Gitコマンド（初心者向け）

### 基本的なGitワークフロー

```bash
# 現在の状態を確認
git status

# 変更されたファイルを確認
git diff

# ファイルをステージングエリアに追加
git add README.md
# または、すべてのファイルを追加
git add .

# コミット（変更を記録）
git commit -m "docs: READMEにセットアップ手順を追加"

# リモートリポジトリに変更を送信
git push origin feature/update-readme
```

### ブランチ操作

```bash
# 現在のブランチを確認
git branch

# 新しいブランチを作成して切り替え
git checkout -b feature/user-registration

# 既存のブランチに切り替え
git checkout main

# ブランチを削除
git branch -d feature/user-registration

# リモートブランチの最新情報を取得
git fetch

# 最新の変更を取得してマージ
git pull origin main
```

### トラブル時のGitコマンド

```bash
# マージコンフリクトが発生した場合
git status  # コンフリクトファイルを確認
# ファイルを手動で編集してコンフリクトを解決
git add app/controllers/users_controller.rb
git commit

# 間違ったファイルをコミットした場合
git reset HEAD~1  # 直前のコミットを取り消し（変更は保持）

# リモートと同期を取る
git fetch origin
git reset --hard origin/main  # ローカルの変更を破棄してリモートと同じ状態にする
```

### 推奨するGitワークフロー（研修生向け）

1.作業開始前

```bash
git checkout main
git pull origin main
git checkout -b feature/user-login
```

2.作業中

```bash
# 定期的に変更を確認
git status
git diff

# 作業が一段落したらコミット
git add .
git commit -m "feat: ログイン機能のコントローラーを追加"
```

3.作業完了後

```bash
git push origin feature/user-login
# GitHubでプルリクエストを作成
```

### Gitのベストプラクティス

- コミットメッセージの書き方

```plaintext
feat: ユーザー登録機能を追加

詳細な説明（必要に応じて）
- メールアドレスとパスワードでの登録機能
- バリデーション機能を実装
- 登録後は自動ログイン状態に遷移
```

- **コミットの粒度**
  - 1つのコミットには関連する変更のみを含める
  - 大きな機能は複数のコミットに分割する

- **ブランチ命名規則**
  - `feature/user-registration`（ユーザー登録機能）
  - `fix/login-bug`（ログインバグ修正）
  - `update/readme-setup`（README更新）

### 実際の開発例

以下は、実際の開発でよく使われるGitワークフローの具体例です：

#### 例1: 新機能開発（ユーザー登録機能）

```bash
# 1. 最新のmainブランチから開始
git checkout main
git pull origin main

# 2. 新しいブランチを作成
git checkout -b feature/user-registration

# 3. ファイルを編集後、変更を確認
git status
git diff

# 4. 変更をコミット
git add app/models/user.rb
git commit -m "feat: Userモデルを追加

- email, passwordフィールドを持つUserモデルを作成
- email必須、パスワード6文字以上のバリデーション
- has_secure_passwordを使用してパスワードを暗号化"

# 5. コントローラーも追加
git add app/controllers/users_controller.rb
git commit -m "feat: ユーザー登録コントローラーを追加

- new, create, showアクションを実装
- Strong Parametersを使用してセキュリティを確保"

# 6. ビューも追加
git add app/views/users/
git commit -m "feat: ユーザー登録フォームを追加

- 登録フォームビューを作成
- エラーメッセージの表示機能を追加"

# 7. リモートにプッシュ
git push origin feature/user-registration

# 8. GitHubでプルリクエストを作成
```

#### 例2: バグ修正（ログインエラー）

```bash
# 1. バグ修正用ブランチを作成
git checkout main
git pull origin main
git checkout -b fix/login-error

# 2. 問題のファイルを修正
git add app/controllers/sessions_controller.rb
git commit -m "fix: ログイン時のエラーハンドリングを修正

- 存在しないユーザーでログインしようとした時の処理を改善
- より分かりやすいエラーメッセージを表示"

# 3. テストも修正
git add test/controllers/sessions_controller_test.rb
git commit -m "test: ログインエラーのテストケースを追加"

# 4. プッシュしてPR作成
git push origin fix/login-error
```

#### 例3: ドキュメント更新

```bash
# 1. ドキュメント更新用ブランチ
git checkout -b update/readme-deployment

# 2. READMEを更新
git add README.md
git commit -m "docs: デプロイ手順をREADMEに追加

- Herokuへのデプロイ手順を詳細に記載
- 環境変数の設定方法を追加"

# 3. プッシュ
git push origin update/readme-deployment
```

## ディレクトリ構成

```
teamB-2025/
├── app/                    # アプリケーションのメインコード
│   ├── controllers/        # コントローラー
│   ├── models/            # モデル
│   ├── views/             # ビュー（テンプレート）
│   ├── helpers/           # ヘルパーメソッド
│   └── assets/            # CSS、画像などの静的ファイル
├── config/                # 設定ファイル
│   ├── database.yml       # データベース設定
│   ├── routes.rb          # ルーティング設定
│   └── environments/      # 環境別設定
├── db/                    # データベース関連
│   ├── migrate/           # マイグレーションファイル
│   └── seeds.rb           # シードデータ
├── docker compose.yml     # Docker Compose設定
├── Dockerfile             # Docker設定
├── Gemfile               # Ruby gem依存関係
└── README.md             # このファイル
```

## 研修の進め方

### 初心者向けガイド

1. **Week 1-2**: Ruby on Railsの基礎学習
   - [Rails Guides](https://guides.rubyonrails.org/)を読む
   - 簡単なCRUD操作を理解する

2. **Week 3-4**: 基本機能の実装
   - ユーザー登録・ログイン機能
   - 基本的なデータベース操作

3. **Week 5-6**: 応用機能の追加
   - ファイルアップロード
   - バリデーション機能

4. **Week 7-8**: テストとデプロイ
   - テストコードの作成
   - デプロイ手順の学習

### 学習リソース

- [Ruby on Rails Tutorial](https://railstutorial.jp/)
- [Rails Guides](https://guides.rubyonrails.org/)
- [Ruby公式ドキュメント](https://docs.ruby-lang.org/ja/)

## コントリビューション

### Issue作成（課題・要望の管理）

新しい機能や修正したいバグを見つけた時は、まずIssueを作成しましょう。

#### Issueの作成手順

1. **GitHubリポジトリページにアクセス**
   - [https://github.com/cirkit-dev/teamB-2025](https://github.com/cirkit-dev/teamB-2025)

2. **Issueタブをクリック**

3. **「New issue」ボタンをクリック**

4. **Issue情報を入力**
   ```
   タイトル: [機能追加] ユーザー登録機能の実装
   
   ## 概要
   ユーザーが新規登録できる機能を追加したい
   
   ## 詳細
   - メールアドレスとパスワードで登録
   - バリデーション機能を含む
   - 登録後は自動でログイン状態にする
   
   ## タスク
   - [ ] ユーザーモデルの作成
   - [ ] 登録フォームの作成
   - [ ] バリデーションの実装
   - [ ] テストコードの作成
   
   ## 担当者
   @username （担当希望者を記載）
   ```

5. **ラベルを設定**
   - `enhancement`: 新機能
   - `bug`: バグ修正
   - `documentation`: ドキュメント更新
   - `good first issue`: 初心者向け

### ブランチ戦略

- `main`: 本番ブランチ
- `develop`: 開発ブランチ
- `feature/機能名`: 機能開発ブランチ
- `fix/バグ名`: バグ修正ブランチ

### プルリクエスト（PR）作成の詳細手順

#### 1. 作業開始前の準備

```bash
# 最新のmainブランチを取得
git checkout main
git pull origin main

# Issueに対応するブランチを作成
git checkout -b feature/issue-123-user-registration
```

#### 2. 開発作業

```bash
# 定期的にコミット
git add .
git commit -m "feat: ユーザーモデルを追加

- email, passwordフィールドを持つUserモデルを作成
- バリデーションを追加（email必須、パスワード6文字以上）
- has_secure_passwordを使用"

# 必要に応じて追加のコミット
git commit -m "feat: ユーザー登録コントローラーを追加"
git commit -m "feat: 登録フォームビューを作成"
```

#### 3. プルリクエストの作成

```bash
# ブランチをリモートにプッシュ
git push origin feature/issue-123-user-registration
```

**GitHubでPRを作成:**

1. **GitHubリポジトリページで「Compare & pull request」をクリック**

2. **PR情報を入力**
   ```
   タイトル: [Issue #123] ユーザー登録機能の実装
   
   ## 概要
   Fixes #123
   
   ユーザーがメールアドレスとパスワードで新規登録できる機能を実装しました。
   
   ## 変更内容
   - Userモデルの追加（email, passwordフィールド）
   - UsersControllerの実装（new, create, show）
   - 登録フォームビューの作成
   - バリデーション機能の実装
   - テストコードの追加
   
   ## 確認事項
   - [ ] テストが全て通ること
   - [ ] コードスタイルチェック（RuboCop）が通ること
   - [ ] 実際にブラウザで動作確認ができること
   
   ## スクリーンショット
   （必要に応じて機能の画面キャプチャを添付）
   
   ## レビュー観点
   - セキュリティ面での問題はないか
   - パフォーマンス面での問題はないか
   - コードの可読性は適切か
   ```

3. **レビュアーを指定**
   - メンターを Reviewers に追加

4. **ラベルとマイルストーンを設定**

5. **「Create pull request」をクリック**

#### 4. コードレビューへの対応

**レビューコメントがついた場合:**

```bash
# 修正を行う
git add .
git commit -m "fix: レビュー指摘事項を修正

- パスワード確認フィールドを追加
- エラーメッセージの表示を改善"

# 修正をプッシュ
git push origin feature/issue-123-user-registration
```

#### 5. マージ後のクリーンアップ

```bash
# mainブランチに戻る
git checkout main

# 最新を取得
git pull origin main

# 作業ブランチを削除
git branch -d feature/issue-123-user-registration
```

### プルリクエストのベストプラクティス

#### PRのタイトル・説明文

- **タイトル**: `[Issue #番号] 簡潔な変更内容`
- **説明文には以下を含める**:
  - 関連するIssue番号（`Fixes #123`で自動クローズ）
  - 変更内容の概要
  - 確認すべき観点
  - スクリーンショット（UI変更の場合）

#### コミットメッセージの規則

```bash
# 推奨フォーマット
<type>: <subject>

<body>

# type の例
feat: 新機能
fix: バグ修正
docs: ドキュメント更新
style: フォーマット修正
refactor: リファクタリング
test: テスト追加
chore: 雑務

# 例
feat: ユーザー登録機能を追加

- メールアドレスとパスワードでの登録
- バリデーション機能を実装
- 登録後は自動ログイン
```

#### レビュー時のチェックポイント

**レビュアー（メンター）向け:**
- 機能要件を満たしているか
- セキュリティ上の問題はないか
- コードの品質は適切か
- テストは十分か

**レビュイー（研修生）向け:**
- PRの説明は十分詳細か
- 全てのテストがパスしているか
- RuboCopによるコードチェックは通っているか
- 動作確認は完了しているか

### GitHubの便利機能

#### GitHubの便利機能

#### Draft Pull Request
開発途中でフィードバックが欲しい場合は「Draft」として作成

#### プルリクエストテンプレート
`.github/pull_request_template.md`を作成すると、PR作成時に自動でテンプレートが表示される

#### Issueテンプレート
`.github/ISSUE_TEMPLATE/`ディレクトリにテンプレートを用意済み：
- `feature_request.md`: 新機能の提案用
- `bug_report.md`: バグ報告用  
- `question.md`: 質問・相談用

#### 自動化
- CI/CDパイプラインでテスト自動実行
- マージ時の自動デプロイ

### プルリクエストの流れ

1. 新しいブランチを作成
2. 機能を実装
3. テストを書く
4. プルリクエストを作成
5. メンターによるコードレビュー
6. マージ

## トラブルシューティング

### よくある問題

**Q: `docker compose up`でエラーが出る**  
A: Dockerが正しくインストールされているか確認し、Dockerデーモンが起動していることを確認してください。

**Q: データベースに接続できない**  
A: `docker compose down`でコンテナを停止してから、`docker compose up --build`で再起動してください。

**Q: Gemが見つからない**  
A: `docker compose exec rails bundle install`でGemを再インストールしてください。

## サポート

質問や問題がある場合は、以下の方法でサポートを受けることができます：

- **メンター**: プロジェクトのメンターに直接相談
- **Issues**: GitHubのIssue機能を使用
- **チーム内ディスカッション**: 直接の質問かSlackにて

## ライセンス

このプロジェクトは研修目的で作成されており、学習用途に限定されます。

---

**Happy Coding!**

研修期間中は完璧を求めず、失敗を恐れずにたくさんのことにチャレンジしてください。  
成長のプロセスを楽しみながら、素晴らしいアプリケーションを一緒に作りましょう！
