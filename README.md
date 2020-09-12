# README

# テーブル設計

## users テーブル

| Column              | Type   | Options     |
| ------------------- | ------ | ----------- |
| nickname            | string | null: false |
| email               | string | null: false |
| password            | string | null: false |
| family_name         | string | null: false |
| last_name           | string | null: false |
| family_name_reading | string | null: false |
| last_name_reading   | string | null: false |
| birth_date          | date   | null: false |

### Association
- has_many :items
- has_many :comments, dependent::destroy
- has_many :purchasers

## items テーブル

| Column           | Type       | Options                        |
|----------------- | ---------- | ------------------------------ |
| name             | string     | null: false                    |
| description      | text       | null: false                    |
| price            | integer    | null: false                    |
| user             | references | null: false, foreign_key: true |
| category_id      | integer    | null: false                    |
| condition_id     | integer    | null: false                    |
| handling_time_id | integer    | null: false                    |
| postage_payer_id | integer    | null: false                    |
| prefecture_id    | integer    | null: false                    |
| image_id         | integer    | null: false                    |

### Association
- belongs_to :user
- has_many :comments, dependent::destroy
- has_one :purchaser
- has_one_attached_image :image
- belongs_to_active_hash :category
- belongs_to_active_hash :condition
- belongs_to_active_hash :handling_time
- belongs_to_active_hash :postage_payer
- belongs_to_active_hash :prefecture

### Active Hash
| Column(_id)   | Type    | Options     |
| ------------- | ------- | ----------- |
| category      | integer | null: false |
| condition     | integer | null: false |
| handling_time | integer | null: false |
| postage_payer | integer | null: false |
| prefecture    | integer | null: false |

## purchasers テーブル

| Column | Type       | Options                        |
| ------ | -------    | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :address

## addresses テーブル
| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| zip_code      | string     | null: false                    |
| prefecture_id | integer    | null: false                    |
| city          | string     | null: false                    |
| house_number  | string     | null: false                    |
| building_name | string     |                                |
| phone_number  | string     | null: false                    |
| purchaser     | references | null: false, foreign_key: true |

### Association
- belongs_to :purchaser
- belongs_to_active_hash :prefecture

## comments テーブル

| Column  | Type       | Options                        |
| ------- | -------    | ------------------------------ |
| content | text       | null: false                    |
| user    | references | null: false, foreign_key: true |
| item    | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item

