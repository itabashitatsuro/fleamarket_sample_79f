class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
  # validates :nickname
  # validates :family_name
  # validates :first_name
  # validates :family_name_kana
  # validates :first_name_kana
  # validates :birthday
  end

  # has_many: items
  # has_many: comments、dependent：：destroy
  # has_many: favorites、dependent：：destroy
  # has_one：profile、dependent：：destroy
  # has_one：addresses、dependent：：destroy
  # has_one：sns_authentications、dependent：：destroy
  # has_many :buyer_items, foreign_key: "buyer_id", class_name: "items"
  # has_many :saling_items, -> { where("buyer_id is NULL") }, foreign_key: "saler_id", class_name: "Item"
  # has_many :sold_items, -> { where("buyer_id is not NULL") }, foreign_key: "saler_id", class_name: "Item

  # has_one :credit_card, dependent: :destroy
  # has_one :address, dependent: :destroy
  # has_many :items, dependent: :destroy
  # has_many :comments 
end
# 一人一枚まで登録
