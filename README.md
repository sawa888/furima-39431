# 【furima-39431】テーブル設計


## users テーブル

| Column                | Type   | Options                   |
| ------------------    | ------ | ------------------------- |
| nickname              | string | null: false               |
| email                 | string | null: false, unique: true |
| encrypted_password    | string | null: false               |
| last_name             | string | null: false               |
| first_name            | string | null: false               |
| last_name_kana        | string | null: false               |
| first_name_kana       | string | null: false               |
| birth_day             | date   | null: false               |

### Association
-has_many :orders
-has_many :items


## items テーブル

| Column                | Type       | Options                        | 
| -------------------- -| ---------- | ------------------------------ | 
| product_name          | string     | null: false                    | 商品名
| present               | text       | null: false                    | 商品の説明
| category_id           | integer    | null: false                    | カテゴリー / ActiveHash
| condition_id          | integer    | null: false                    | 商品の状態 / ActiveHash
| delivery_charge_id    | integer    | null: false                    | 配送料の負担 / ActiveHash
| shipping_address_id   | integer    | null: false                    | 発送元の地域  / ActiveHash
| delivery_time_id      | integer    | null: false                    | 発送までの日数 / ActiveHash
| price                 | integer    | null: false                    |
| user                  | references | null: false, foreign_key: true	| 外部キー

### Association
-belongs_to :user
-has_one :order
-has_one_attached :image


## orders テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user    | references | null: false, foreign_key: true | 外部キー
| item    | references | null: false, foreign_key: true | 外部キー

### Association
-has_one :delivery_address
-belongs_to :user
-belongs_to :item


## delivery_addresses テーブル

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| postal_code         | string     | null: false                    | 郵便番号
| shipping_address_id | integer    | null: false                    | 都道府県 / ActiveHash
| city                | string     | null: false                    | 市区町村
| street_address      | string     | null: false                    | 番地
| building_name       | string     |                                | 建物名
| phone_number        | string     | null: false                    | 電話番号
| order               | references | null: false, foreign_key: true | 外部キー

### Association
-belongs_to :order


