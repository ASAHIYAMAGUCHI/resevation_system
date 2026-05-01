class Price < ApplicationRecord
  has_many :daily_slots, foreign_key: :price_id, dependent: :restrict_with_error

  validates :price_name, presence: true
  validates :adult_price, :student_price, :child_price, :infant_price,
            presence: true, numericality: { greater_than_or_equal_to: 0 }
end
