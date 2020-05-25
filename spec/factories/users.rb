FactoryBot.define do
  factory :user do
    email { FFaker::Internet.unique.email }
    nickname { FFaker::Internet.user_name }
    password { FFaker::Internet.password }
  end
end