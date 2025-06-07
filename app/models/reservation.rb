class Reservation < ApplicationRecord
  belongs_to :guest, class_name: 'User'
  belongs_to :accommodation

  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :end_date_after_start_date
  validate :no_overlapping_reservations

  def duration_days
    return 0 unless start_date && end_date
    (end_date.to_date - start_date.to_date).to_i
  end

  def overlaps_with?(other_reservation)
    return false if other_reservation == self
    return false unless other_reservation.is_a?(Reservation)
    start_date < other_reservation.end_date && end_date > other_reservation.start_date
  end

  def overlaps_with_period?(start_datetime, end_datetime)
    start_date < end_datetime && end_date > start_datetime
  end

  private

  def end_date_after_start_date
    return unless start_date && end_date

    if end_date <= start_date
      errors.add(:end_date, "Should be after start_date")
    end
  end

  def no_overlapping_reservations
    return unless start_date && end_date && accommodation

    other_reservations = accommodation.reservations.where.not(id: id)
    overlapping = other_reservations.any? { |reservation| overlaps_with?(reservation) }

    if overlapping
      errors.add(:base, "These dates are not available as they have already been booked.")
    end
  end
end
