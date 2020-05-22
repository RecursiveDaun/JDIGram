class Comment < ApplicationRecord
  belongs_to  :post
  belongs_to  :author, class_name: 'UserProfile', foreign_key: 'author_id'
end
