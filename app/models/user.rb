class User < ApplicationRecord

  #================== Associations ==================
  has_one :user_profile

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

  #================== Validates And Collbacks ==================
  validates :link_hash, length: { is: 10 }

  before_validation do
    generate_unique_link_hash
  end

  #================== Elasticsearch ==================
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  index_name Rails.application.class.parent_name.underscore
  document_type self.name.downcase

  settings index: { number_of_shards: 1 } do
    mapping dynamic: false do
      indexes :nickname, analyzer: 'english', type: :text
    end
  end

  def as_indexed_json(options = nil)
    self.as_json( only: [ :nickname ] )
  end

  # def self.search(query)
  #   __elasticsearch__.search(
  #       {
  #           query: {
  #               multi_match: {
  #                   query: query,
  #                   fields: ['title^5', 'body']
  #               }
  #           },
  #       }
  # end

  #================== Private Methods ==================
  private

  def generate_unique_link_hash
    begin
      self.link_hash = SecureRandom.hex(5)
    end while self.class.exists?(link_hash: self.link_hash)
  end

end
