class Property < ApplicationRecord
  validates :operation_type,:location,:price,:property_type,:bathroom,:bedroom,:area,:description, presence: true

  has_many :interactions
  belongs_to :user
end
