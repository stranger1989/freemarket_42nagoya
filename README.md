# DB設計

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|id|integer|null: false, primary_key: true|
|nickname|string|null: false|
|profile|text| |
|avatar|text| |
|email|varchar(255)|null: false, unique_key: true|
|password|varchar(255)|null: false|
|lastname|string|null: false|
|firstname|string|null: false|
|lastname_kana|string|null: false|
|firstname_kana|string|null: false|
|postalcode|varchar(7)|null: false|
|prefecture|string|null: false|
|city|string|null: false|
|block|string|null: false|
|building|string| |
|birthday|datetime|null: false|
|phone_number|string|null: false|
|payment|string|null: false|
|created_at|datetime|null: false|
|updated_at|datetime|null: false|

### Association
- has_many :items
- has_many :evaluations
- has_many :likes
- has_many :orders
- has_many :comments

***

## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|id|integer|null: false, primary_key: true|
|name|string|null: false, index: true|
|image|text| |
|price|integer|null: false|
|order_status|string|null: false|
|status|string|null: false|
|shipping_fee|string|null: false|
|delivery_way|string|null: false|
|shipping_area|string|null: false|
|estimated_shipping_date|datetime|null: false|
|description|text|null: false|
|user_id|integer|foreign_key: true|
|category_id|integer|foreign_key: true|
|brand_id|integer|foreign_key: true|
|created_at|datetime|null: false|
|updated_at|datetime|null: false|

### Association
- belongs_to :user
- belongs_to :category
- belongs_to :brand
- belongs_to :order
- has_many :comments

***

## likesテーブル
|Column|Type|Options|
|------|----|-------|
|id|integer|null: false, primary_key: true|
|user_id|integer|foreign_key: true|
|item_id|integer|foreign_key: true|
|created_at|datetime|null: false|
|updated_at|datetime|null: false|

### Association
- belongs_to :user
- belongs_to :item

***

## evaluationsテーブル
|Column|Type|Options|
|------|----|-------|
|id|integer|null: false, primary_key: true|
|status|string|null: false|
|user_id|integer|foreign_key: true|
|to_user_id|integer|foreign_key: true|
|created_at|datetime|null: false|
|updated_at|datetime|null: false|

### Association
- belongs_to :user

***

## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|id|integer|null: false, primary_key: true|
|parent_id|integer|null: false|
|name|string|null: false, index: true|
|created_at|datetime|null: false|
|updated_at|datetime|null: false|

### Association
- has_many :items
- has_many :brands, through: :categories_brands
- has_many :brands

***

## brandsテーブル
|Column|Type|Options|
|------|----|-------|
|id|integer|null: false, primary_key: true|
|name|string|null: false, index: true|
|created_at|datetime|null: false|
|updated_at|datetime|null: false|

### Association
- has_many :items
- has_many :categories, through: :categories_brands
- has_many :categories

***

## categories_brandsテーブル
|Column|Type|Options|
|------|----|-------|
|id|integer|null: false, primary_key: true|
|brand_id|integer|foreign_key: true|
|category_id|integer|foreign_key: true|
|created_at|datetime|null: false|
|updated_at|datetime|null: false|

### Association
- belongs_to :category
- belongs_to :brand

***

## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|id|integer|null: false, primary_key: true|
|text|text|null: false|
|user_id|integer|foreign_key: true|
|item_id|integer|foreign_key: true|
|created_at|datetime|null: false|
|updated_at|datetime|null: false|

### Association
- belongs_to :user
- belongs_to :item

***

## ordersテーブル
|Column|Type|Options|
|------|----|-------|
|id|integer|null: false, primary_key: true|
|user_id|integer|foreign_key: true|
|item_id|integer|foreign_key: true|
|created_at|datetime|null: false|
|updated_at|datetime|null: false|

### Association
- belongs_to :item
- belongs_to :user

***

## newsテーブル
|Column|Type|Options|
|------|----|-------|
|id|integer|null: false, primary_key: true|
|text|text|null: false|
|created_at|datetime|null: false|
|updated_at|datetime|null: false|
