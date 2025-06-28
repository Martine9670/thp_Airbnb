class Listing < ApplicationRecord

    validates :description, presence: true, length: { minimum: 140 }
    has_many :reservations
    belongs_to :city

  def overlapping_reservation?(new_start_date, new_end_date)
    reservations.any? do |reservation|
      reservation.overlaps?(new_start_date, new_end_date)
    end
  end
end
