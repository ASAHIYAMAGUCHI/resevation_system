class DailySlot < ApplicationRecord
  self.primary_key = 'applicable_date'

  enum :status, {
    open:           'open',
    closed_regular: 'closed_regular',
    closed_temp:    'closed_temp',
    suspended:      'suspended'
  }

  belongs_to :price, optional: true
  has_many :reservations, foreign_key: :daily_slot_date,
                          primary_key: :applicable_date,
                          dependent: :restrict_with_error

  validates :applicable_date, presence: true
  validates :max_capacity, presence: true, numericality: { greater_than: 0 }, if: :open?
  validates :price_id,     presence: true, if: :open?

  def start_time
    applicable_date.to_time
  end
end
