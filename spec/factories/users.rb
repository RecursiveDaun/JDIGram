FactoryBot.define do
  factory :user do
    email { FFaker::Internet.unique.email }
    nickname { FFaker::Internet.unique.user_name }
    password { '123123' }
  end
end