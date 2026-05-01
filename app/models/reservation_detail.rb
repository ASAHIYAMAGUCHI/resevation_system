class ReservationDetail < ApplicationRecord
  enum :person_type, {
    adult:   'adult',
    student: 'student',
    child:   'child',
    infant:  'infant'
  }

  belongs_to :reservation, foreign_key: :res_code, primary_key: :res_code

  validates :person_type, presence: true
  validates :number_of_people, presence: true, numericality: { greater_than: 0 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :subtotal, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
