class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :ten_symbols_hash, length: { is: 10 }

  has_one :user_profile

  attr_writer :login

  def login
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

  before_validation do
    generate_unique_hash
  end

  private

  def generate_unique_hash
    self.ten_symbols_hash = self.id.to_s + SecureRandom.alphanumeric(10 - user_id.length)
  end

end
