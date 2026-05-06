class DailySlot < ApplicationRecord
  self.primary_key = 'applicable_date'

  belongs_to :price
  has_many :reservations, foreign_key: :daily_slot_date,
                          primary_key: :applicable_date,
                          dependent: :restrict_with_error

  validates :applicable_date, presence: true
  validates :max_capacity, presence: true, numericality: { greater_than: 0 }

  def start_time
    applicable_date.to_time
  end
end
