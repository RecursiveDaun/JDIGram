class Like < ApplicationRecord
  belongs_to :author, class_name: 'UserProfile', foreign_key: 'author_id'
  belongs_to :post
end
