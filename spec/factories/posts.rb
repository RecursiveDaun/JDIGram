FactoryBot.define do
  factory :post do
    user_profile_id { user_profile_id }
    description { 'Description' }
    photo { Rack::Test::UploadedFile.new('/Users/user/megasync/arts/another arts/2D/love attack.jpg', 'image/png') }
  end
end