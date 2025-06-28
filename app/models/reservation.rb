class Reservation < ApplicationRecord
    belongs_to :guest, class_name: "User"
    belongs_to :listing

    validate :no_overlapping_reservations

    scope :past, -> { where("end_date < ?", Date.today) }
    scope :future, -> { where("start_date >= ?", Date.today) }

    def duration
        (end_date - start_date).to_i
    end

    def overlaps?(new_start_date, new_end_date)
    # Une réservation est en conflit s’il y a un chevauchement
    (start_date...end_date).overlaps?(new_start_date...new_end_date)
  end

  private

    def no_overlapping_reservations
        return unless start_date && end_date && listing_id

        overlapping = listing.reservations.where.not(id: id).any? do |reservation|
        reservation.overlaps?(start_date, end_date)
        end

        errors.add(:base, "Cette période est déjà réservée. Merci de choisir d'autre dates.") if overlapping
    end
end
