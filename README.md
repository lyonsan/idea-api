# アプリ概要
アイデアを管理するAPI

# 機能

## アイデア登録
アイデアのカテゴリー名と、アイデアの中身をリクエストで送ることで、アイデアが登録できる。

## アイデア取得
データベースに登録されているアイデアのカテゴリー名と、アイデアの中身を取得できる。
カテゴリー名をリクエストで指定すれば、そのカテゴリー名に該当するデータのみを返してくれる。

# データベース設計

### categoriesテーブル

| Column             | Type     | option       |
|--------------------|----------|--------------|
| name               | string   | null: false  |
#### Association
- has_many: ideas

### ideasテーブル

| Column             | Type       | option                          |
|--------------------|------------|---------------------------------|
| category           | references | null: false, foreign_key: true  |
| body               | text       | null: false                     |
#### Association
- belongs_to: category