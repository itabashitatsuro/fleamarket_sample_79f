FactoryBot.define do
  FactoryBot.define do

    factory :item do
      name                  {"aaaa"}
      introduction          {"bbbbbbbbbbb"}
      price                 {"12345"}
      status_id             {"1"}
      shipping_charge_id    {"1"}
      delivery_fee_id       {"1"}
      prefecture_id         {"1"}
      shopping_date_id      {"1"}
      category_id           {"1"}
      brand                 {"ブランド"}
      seller                { create(:user) }
      buyer                 { nil }

      after(:build) do |item|
        item.item_images << build(:item_image)
      end
    end

end