class User < ApplicationRecord

  PHONE_REGEXP = /\A(\+?\d{2})?\s?\d{9}\z/.freeze

  has_secure_password
  has_secure_token

  validates :name, presence: true
  validates :type_user, presence: true

  validates :email, presence: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP },
                    uniqueness: true

  validates :password, presence: true, length: { minimum: 6 }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :properties
  has_many :interactions
end
