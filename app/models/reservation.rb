class Reservation < ApplicationRecord
  self.primary_key = 'res_code'

  enum :status, {
    pending:   'pending',
    confirmed: 'confirmed',
    visited:   'visited',
    cancelled: 'cancelled'
  }

  belongs_to :daily_slot, foreign_key: :daily_slot_date, primary_key: :applicable_date
  has_many :reservation_details, foreign_key: :res_code,
                                  primary_key: :res_code,
                                  dependent: :destroy

  accepts_nested_attributes_for :reservation_details, allow_destroy: true

  validates :res_code, presence: true, uniqueness: true, length: { maximum: 10 }
  validates :personal_name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :total_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :daily_slot_date, presence: true
end
