# チーム名

Cirkit-a

# プロダクト名

プロダクト名を記載してください。

## 概要

課題管理アプリを作りました。
一目でわかるような使い方や、わかりやすい色味を利用しました。。
課題の一覧が表示される画面では、期限日順になるような機能や期限日を超えてしまったものの色味を変更する機能が搭載されています。


## デモ

以下を掲載してください。

- file:///C:/Users/jinze/OneDrive/Desktop/cirkit-a.pdf
- [text](file:///c%3A/Users/jinze/Downloads/README_template.md)


## システム構成

###全体構成
Docker上に「Railsアプリ」と「MySQL」という2つのコンテナが立っていて、ブラウザからのアクセスを受け取って処理する、という構成です。


## 背景・課題

チームメンバー全員で話し合いを行った結果、課題管理を行うアプリの需要が高いことがわかりました。

## 主な機能

- 機能1：課題を入力し、期限日順で表示させる機能
- 機能2：完了ボタンを押すと、課題一覧に戻る機能
- 機能3：入力間違いを編集する機能

## 工夫した点・こだわった点

課題の期限が過ぎたものを紫色で表示し、課題の期限が今日までのものは赤色で表示するなど、一目で課題の状況がわかるように工夫しました。
また、落ち着いた色味を使うことで目に優しく視認しやすい工夫をしました。

## 使用技術

- フロントエンド：HTML/CSS
- バックエンド：Ruby on rails
- AI / API：
- データベース：SQL
- インフラ：
- その他：

## 今後の展望

キャラクターを付けて、親しみやすいデザインにしたり、Deviceの機能を付けたいと考えています。

## セットアップ方法

前提条件
Docker Desktop がインストール・起動していること
Git が利用可能であること

# A. 前提パッケージのインストールとセットアップ
sudo apt update
sudo apt install -y rbenv ruby-build mysql-server mysql-client libmysqlclient-dev

# rbenv のパスを通す（初回のみ必要）
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
exec $SHELL -l

# Rubyのインストール
rbenv install 3.2.2
rbenv global 3.2.2

# MySQLの起動と初期設定
sudo service mysql start
sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root'; FLUSH PRIVILEGES;"

# B. リポジトリへの移動と gem インストール
# ※クローン先のパスに合わせて指定（例: ~/2026hackit/cirkit2026）
cd ~/2026hackit/cirkit2026
bundle install

# C. DB接続先環境変数の設定
export DATABASE_URL="mysql2://root:root@127.0.0.1:3306/cirkit2026_development"

# D. DBの作成とマイグレーション
rails db:create
rails db:migrate

# ※課題が表示されない場合のデータ補正
rails runner "Task.where(completed: nil).update_all(completed: false)"
rails runner "ActiveRecord::Base.connection.change_column_default(:tasks, :completed, false)"

# E. サーバー起動（※Docker側が起動している場合は事前に docker compose down が必要）
rails s


## メンバー

| 名前 | 担当 |
|------|------|
| 　山上　|  バックエンド  |
|  　水野  |   バックエンド   |
| 　小此木　|  バックエンド  |
|    師岡  |   フロントエンド   |
|    本多  |   フロントエンド   |
