FactoryBot.define do

  factory :user do
    nickname              {"abe"}
    email                 {"kkk@gmail.com"}
    password              {"00000000"}
    password_confirmation {"00000000"}
    family_name           {"nakamura"}
    first_name            {"satochika"}
    family_name_kana      {"ナカムラ"}
    first_name_kana       {"サトチカ"}
    birthday              {"1988年10月27日"}
  end

end
