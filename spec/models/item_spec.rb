require 'rails_helper'
describe Item do
  describe '#create' do

    # priceとname、とintroduction、prefecture、shopping_date、delivery_fee、status、imageが存在すれば登録できること
    it "is valid with a priceとname,introduction,prefecture,shopping_date,delivery_fee,status,image" do
      item = build(:item)
      expect(user).to be_valid
    end
    
    # priceが空では登録できないこと
    it "is invalid without a price" do
      item = build(:item, price: "")
      item.valid?
      expect(item.errors[:price]).to include("can't be blank")
    end
    
    # nameが空では登録できないこと
    it "is invalid without a name" do
      item = build(:item, name: "")
      item.valid?
      expect(item.errors[:name]).to include("can't be blank")
    end

    # introductionが空では登録できないこと
    it "is invalid without a introduction" do
      item = build(:item, introduction: "")
      item.valid?
      expect(item.errors[:introduction]).to include("can't be blank")
    end

    # prefectureが空では登録できないこと
    it "is invalid without a prefecture" do
      item = build(:item, prefecture: "")
      item.valid?
      expect(item.errors[:prefecture]).to include("can't be blank")
    end

    # shopping_dateが空では登録できないこと
    it "is invalid without a shopping_date" do
      item = build(:item, shopping_date: "")
      item.valid?
      expect(item.errors[:shopping_date]).to include("can't be blank")
    end

    # delivery_feeが空では登録できないこと
    it "is invalid without a delivery_fee" do
      item = build(:item, delivery_fee: "")
      item.valid?
      expect(item.errors[:delivery_fee]).to include("can't be blank")
    end

    # statusが空では登録できないこと
    it "is invalid without a status" do
      item = build(:item, status: "")
      item.valid?
      expect(item.errors[:status]).to include("can't be blank")
    end

    # imageが空では登録できないこと
    it "is invalid without a image" do
      item = build(:item, image: "")
      item.valid?
      expect(item.errors[:image]).to include("can't be blank")
    end

    # nameが40文字以下では登録できること
    it "is valid with a name that has less than 40 characters " do
      item = build(:item, name: "a" * 39)
      expect(item).to be_valid
    end

    # nameが41文字以上では登録できないこと
    it "is valid with a name that has more than 41 characters " do
      item = build(:item, name: "a" * 41)
      item.valid?
      expect(item.errors[:name]).to include("is too long (maximum is 40 characters)")
    end

    # introductionが1000文字以下では登録できること
    it "is valid with a introduction that has less than 1000 characters" do
      item = build(:item, introduction: "a" * 1000)
      expect(item).to be_valid
    end

    # introductionが1000文字超過なら登録できないこと
    it "is valid with a introduction that has more than 1001 characters " do
      item = build(:item, introduction: "a" * 1001)
      item.valid?
      expect(item.errors[:introduction]).to include("is too long (maximum is 1000 characters)")
    end



  end
end