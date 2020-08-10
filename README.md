# DB設計 fleamarket_sample_79f
## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false, unique:true|
|password|string|null: false|
|password_confirmation|string||

|first＿name|string|null: false|
|family_name|string|null: false|
|first＿name_kana|string|null: false|
|family_name_kana|string|null: false|
|birthday|date|null: false|

### Association
- has_many: items
- has_many: comments、dependent：：destroy
- has_many: favorites、dependent：：destroy
- has_one：profile、dependent：：destroy
- has_one：addresses、dependent：：destroy
- has_one：sns_authentications、dependent：：destroy
- has_many :buyer_items, foreign_key: "buyer_id", class_name: "items"
- has_many :saling_items, -> { where("buyer_id is NULL") }, foreign_key: "saler_id", class_name: "Item"
- has_many :sold_items, -> { where("buyer_id is not NULL") }, foreign_key: "saler_id", class_name: "Item




## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|user|references|null: false, foreign_key: true|
|name|string|null: false|
|price|integer|null: false|
|introduction|text|null: false|
|brand|string|
|status_id|integer|null: false||
|prefecture_id|integer|null: false|
|delivery_fee_id|string|null: false||
|shipping_date_id|string|null: false|
|category|references|null: false, foreign_key: true|
|seller|references|null: false, foreign_key: true|
|buyer|references|foreign_key: true|

### Association
- belongs_to :user
- belongs_to :category
- has_many :comments、dependent：：destroy
- has_many :favorites

- belongs_to :seller, class_name: "User"
- belongs_to :buyer, class_name: "User"

- belongs_to_active_hash :shipping_date
- belongs_to_active_hash :prefecture
- belongs_to_active_hash :delivery_fee
- belongs_to_active_hash :status

- has_many :images
- accepts_nested_attributes_for :images, allow_destroy: true
- has_many :images, dependent: :destroy




# categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|ancestry|string|null: false|
|name|string|null: false|

### Association
- has_many: items




# imagesテーブル
|Column|Type|Options|
|------|----|-------|
|item|references|null: false, foreign_key: true|
|item_image|string|null: false|

### Association
- belongs_to : item




 ## credit_cardsテーブル
|Column|Type|Options|
|------|----|-------|
|user|references|null: false, foreign_key: true|
|card_number|integer|null: false, unique:true|
|card_year|integer|null: false|
|card_month|integer|null: false|
|security_pass|integer|null: false|

### Association
- belongs_to : user




## addressesテーブル
|Column|Type|Options|
|------|----|-------|
|user|references|null: false, foreign_key: true|
|postal_code|string|null: false|
|prefecture|integer|null: false|
|city|string|null: false|
|address|string|null: false|
|apartment|string||

### Association
- belongs_to : user




## sns_authenticationsテーブル
|Column|Type|Options|
|------|----|-------|
|user|references|null: false, foreign_key: true|
|uid|string|null: false|
|provider|string|null: false|

### Association
- belongs_to : user




# favoritesテーブル
|Column|Type|Options|
|------|----|-------|
|user|references|null: false, foreign_key: true|
|item|references|null: false, foreign_key: true|

### Association
- belongs_to : user
- belongs_to : item




# commentsテーブル
|Column|Type|Options|
|------|----|-------|
|user|references|null: false, foreign_key: true|
|item|references|null: false, foreign_key: true|
|content|text|null: false|

### Association
- belongs_to : user
- belongs_to : item

