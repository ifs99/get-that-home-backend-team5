class User < ApplicationRecord
  before_create do
    self.token_created_at = Time.current
  end

  PHONE_REGEXP = /\A(\+?\d{2})?\s?\d{9}\z/.freeze

  has_secure_password
  has_secure_token

  validates :name, presence: true
  validates :type_user, presence: true

  validates :email, presence: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP },
                    uniqueness: true

  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :password, allow_nil: true, length: { minimum: 6 }, on: :update

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :properties
  has_many :interactions

  def invalidate_token
    update(token: nil, token_created_at: nil)
  end

  def update_token
    regenerate_token
    update(token_created_at: Time.current)
  end

  def self.valid_login?(email, password)
    user = find_by(email: email)
    user if user&.authenticate(password)
  end
end
