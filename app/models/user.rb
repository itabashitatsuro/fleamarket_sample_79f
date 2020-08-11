class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
  validates :nickname
  validates :family_name
  validates :first_name
  validates :family_name_kana
  validates :first_name_kana
  validates :birthday
  end

  has_many :items, dependent: :destroy
  has_many :items
  # has_many :comments,dependent: :destroy
  # has_many :favorites,dependent: :destroy
  # has_one :profile,dependent: :destroy
  has_one :address,dependent: :destroy
  
  # has_one :sns_authentications,dependent: :destroy
  has_one :credit_card, dependent: :destroy
end
