# 【furima-39431】テーブル設計

## users テーブル

| Column                | Type   | Options                   |
| ------------------    | ------ | ------------------------- |
| nickname              | string | null: false               |
| email                 | string | null: false, unique: true |
| password              | string | null: false               |
| password_confirmation | string | null: false               |
| last_name             | string | null: false               |
| first_name            | string | null: false               |
| last_name_ kana       | string | null: false               |
| first_name_kana       | string | null: false               |
| birth_yaer            | string | null: false               |
| birth_month           | string | null: false               |
| birth_day             | string | null: false               |

### Association
-has_many :orders
-has_many :items
-has_one :delivery_address


## items テーブル

| Column                | Type       | Options                        | 
| -------------------- -| ---------- | ------------------------------ | 
| product_name          | string     | null: false                    | 商品名
| present               | string     | null: false                    | 商品の説明
| category_id           | integer    | null: false                    | カテゴリー / ActiveHash
| condition_id          | integer    | null: false                    | 商品の状態 / ActiveHash
| delivery_charge_id    | integer    | null: false                    | 配送料の負担 / ActiveHash
| shipping_address_id   | integer    | null: false                    | 発送元の地域  / ActiveHash
| delivery_time_id      | integer    | null: false                    | 発送までの日数 / ActiveHash
| price                 | string     | null: false                    |
| user_id               | references | null: false, foreign_key: true	|

### Association
-belongs_to :user
-has_one :order


## orders テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user_id | references | null: false, foreign_key: true |
| item_id | references | null: false, foreign_key: true |


### Association
-has_one :delivery_address
-belongs_to :user
-belongs_to :item



## delivery_address テーブル

| Column         | Type       | Options                        |
| -------------- | ------     | ------------------------------ |
| postal_code    | integer    | null: false                    | 郵便番号
| prefecture_id  | integer    | null: false                    | 都道府県 / ActiveHash
| city           | string     | null: false                    | 市区町村
| street_address | text       | null: false                    | 番地
| building_name  | text       | null: false                    | 建物名
| phone_number   | integer    | null: false, unique: true      | 電話番号
| order_id       | references | null: false, foreign_key: true |
| user_id        | references | null: false, foreign_key: true |


### Association
-belongs_to :order
-belongs_to :user

