FactoryBot.define do
  factory :conversation do
    author_id { author_id }
    receiver_id { receiver_id }
  end
end