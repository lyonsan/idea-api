# アプリ概要
アイデアを管理するAPI

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