namespace :db do
  desc 'サンプルデータを登録する'
  task populate: :environment do
    # 50.times do |n|
    #   User.create(
    #     name: "ユーザ#{n}",
    #     email: "user-#{n}@example.com",
    #     password: 'test',
    #     password_confirmation: 'test'
    #   )
    30.times do |n|
      price = 1000 + n
      introduction = n+1
      num = 1
      Item.create!(
        name: "example#{n}",
        price: price,
        introduction: introduction,
        prefecture_id: num,
        status_id: num,
        shipping_date_id: num,
        delivery_fee_id: num,
        user_id: num,
        category_id: 201
      )
    end
  #   30.times do |n|
  #     num = 2 + n
  #     Image.create!(
  #       item_image: "example#{n}",
  #       item_id: num
  #     )
  end
end
