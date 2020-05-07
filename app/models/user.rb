class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :link_hash, length: { is: 10 }

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
    generate_unique_link_hash
  end

  private

  def generate_unique_link_hash
    random_hash = SecureRandom.hex(5)
    while self.class.exists?(link_hash: random_hash) do
      random_hash = SecureRandom.hex(5)
    end
    self.link_hash = random_hash
  end

end
