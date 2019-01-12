# DB設計

## usersテーブル
|Column|Type|Options|
|------|----|-------|
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
|name|string|null: false, index: true|
|image|text| |
|price|integer|null: false|
|order_status|string|null: false|
|item_status|string|null: false|
|shipping_fee|string|null: false|
|delivery_way|string|null: false|
|shipping_area|string|null: false|
|estimated_shipping_date|datetime|null: false|
|description|text|null: false|
|user_id|references|foreign_key: true|
|category_id|references|foreign_key: true|
|brand_id|references|foreign_key: true|
|created_at|datetime|null: false|
|updated_at|datetime|null: false|

### Association
- belongs_to :user
- belongs_to :category
- belongs_to :brand
- belongs_to :order
- has_many :likes
- has_many :comments

***

## likesテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|foreign_key: true|
|item_id|references|foreign_key: true|

### Association
- belongs_to :user
- belongs_to :item

***

## evaluationsテーブル
|Column|Type|Options|
|------|----|-------|
|status|string|null: false|
|user_id|integer| |
|to_user_id|integer| |

### Association
- belongs_to :user

***

## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|parent_id|integer|null: false|
|name|string|null: false, index: true|

### Association
- has_many :items
- has_many :brands, through: :categories_brands
- has_many :categories_brands

***

## brandsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false, index: true|

### Association
- has_many :items
- has_many :categories, through: :categories_brands
- has_many :categories_brands

***

## categories_brandsテーブル
|Column|Type|Options|
|------|----|-------|
|brand_id|references|foreign_key: true|
|category_id|references|foreign_key: true|

### Association
- belongs_to :category
- belongs_to :brand

***

## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|text|text|null: false|
|user_id|references|foreign_key: true|
|item_id|references|foreign_key: true|

### Association
- belongs_to :user
- belongs_to :item

***

## ordersテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|foreign_key: true|
|item_id|references|foreign_key: true|

### Association
- belongs_to :item
- belongs_to :user

***

## newsテーブル
|Column|Type|Options|
|------|----|-------|
|text|text|null: false|
