require 'elasticsearch/model'

class User < ApplicationRecord

  #================== Elasticsearch ==================
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  document_type "json"

  ES_SETTING = {
      index: {
          number_of_shards: 1
      },
      analysis: {
          filter: {
              mynGram: {
                  type: 'ngram',
                  min_gram: 2,
                  max_gram: 8
              }
          },
          analyzer: {
              my_analyzer: {
                  type: 'custom',
                  tokenizer: 'standard',
                  filter: [ 'lowercase', 'mynGram' ]
              }
          },
          max_ngram_diff: 50
      }
  }

  settings ES_SETTING do
    mappings dynamic: 'true' do
      indexes :nickname, type: 'text', analyzer: 'my_analyzer'
      indexes :email, type: 'text', analyzer: 'my_analyzer'
    end
  end

  def update_es
    begin
      __elasticsearch__.update_document
    rescue Elasticsearch::Transport::Transport::Errors::NotFound => e
      __elasticsearch__.index_document
    end
  end

  #================== Associations ==================
  has_one :user_profile, dependent: :destroy

  #================== Validates And Collbacks ==================
  validates :link_hash, length: { is: 10 }

  before_validation do
    generate_unique_link_hash
  end

  after_commit :update_es, on: [:update]
  after_commit on: [:destroy] do
    __elasticsearch__.delete_document
  end

  #================== Devise ==================
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # For sign in with nickname
  attr_writer :login
  def login
    # @login || self.try(:nickname) || self.email
    @login || self.nickname || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(nickname) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:nickname) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  #================== Private Methods ==================
  private

  def generate_unique_link_hash
    begin
      self.link_hash = SecureRandom.hex(5)
    end while self.class.exists?(link_hash: self.link_hash)
  end

end
