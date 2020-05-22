require 'elasticsearch/model'

class UserProfile < ApplicationRecord
  belongs_to :user

  has_many :posts, dependent: :destroy
  has_many :friendships, foreign_key: 'owner_id', dependent: :destroy
  has_many :friendships, foreign_key: 'follower_id', dependent: :destroy
  has_many :authored_conversations, class_name: 'Conversation', foreign_key: 'author_id', dependent: :destroy
  has_many :received_conversations, class_name: 'Conversation', foreign_key: 'receiver_id', dependent: :destroy
  has_many :messages, foreign_key: 'author_id', dependent: :destroy

  has_one_attached  :avatar

  #================== Elasticsearch ==================
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  if Rails.env.development?
    document_type "json"
  end


  ES_SETTING_TWO = {
      analysis: {
          index: {
              number_of_shards: 1,
              max_ngram_diff: 50
          },
          filter: {
              user_profile_nGram: {
                  type: 'ngram',
                  min_gram: 2,
                  max_gram: 3
              }
          },
          analyzer: {
              user_profile_analyzer: {
                  type: 'custom',
                  tokenizer: 'standard',
                  filter: [ 'lowercase', 'user_profile_nGram' ]
              }
          }
      }
  }

  settings ES_SETTING_TWO do
    mappings do
      indexes :name, type: 'text', analyzer: 'user_profile_analyzer'
    end
  end

  def update_es
    begin
      __elasticsearch__.update_document
    rescue Elasticsearch::Transport::Transport::Errors::NotFound => e
      __elasticsearch__.index_document
    end
  end

end
