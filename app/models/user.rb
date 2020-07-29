class User < ApplicationRecord
  has_one :credit_card, dependent: :destroy
  has_one :address, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :comments 
end
# 一人一枚まで登録
