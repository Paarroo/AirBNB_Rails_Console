class Accommodation < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'
  belongs_to :city
  has_many :reservations, dependent: :destroy

  validates :available_beds,
    presence: { message: "Le nombre de lits est obligatoire" },
    numericality: {
      only_integer: true,
      greater_than: 0,
      message: "Le nombre de lits doit être un nombre entier strictement positif"
    }

  validates :price,
    presence: { message: "Price is mandatory" },
    numericality: {
      only_integer: true,
      greater_than: 0,
      message: "Price must be a strictly positive integer (in euros)"
    }

  validates :description,
    presence: { message: "Description is mandatory" },
    length: {
      minimum: 140,
      message: "The description must be at least 140 characters long"
    }

  validates :has_wifi,
    inclusion: {
      in: [ true, false ],
      message: "Please indicate if the accommodation has WiFi"
    }

  validates :welcome_message,
    presence: { message: "Welcome message is mandatory" }

  def wifi_available?
    has_wifi
  end

  def total_price_for_nights(number_of_nights)
    return 0 if number_of_nights <= 0
    price * number_of_nights
  end

  def can_accommodate?(number_of_guests)
    available_beds >= number_of_guests
  end

  def overlapping_reservation?(datetime)
    reservations.any? do |reservation|
      datetime >= reservation.start_date && datetime < reservation.end_date
    end
  end

  def available_for_period?(start_datetime, end_datetime)
    reservations.none? do |reservation|
      start_datetime < reservation.end_date && end_datetime > reservation.start_date
    end
  end

  def unavailable_dates
    reservations.map do |reservation|
      (reservation.start_date.to_date..reservation.end_date.to_date).to_a
    end.flatten.uniq.sort
  end

  def next_available_dates(limit = 10)
    today = Date.current
    available_dates = []

    (0..365).each do |day_offset|
      date = today + day_offset.days
      unless overlapping_reservation?(date.beginning_of_day)
        available_dates << date
        break if available_dates.size >= limit
      end
    end
    available_dates
  end

  def to_s
    "#{city.name} - #{available_beds} lits - #{price}€/nuit#{wifi_available? ? ' (WiFi)' : ''}"
  end

  scope :with_wifi, -> { where(has_wifi: true) }
  scope :without_wifi, -> { where(has_wifi: false) }
  scope :by_price_range, ->(min_price, max_price) { where(price: min_price..max_price) }
  scope :by_capacity, ->(min_beds) { where('available_beds >= ?', min_beds) }
  scope :available_on, ->(date) {
    where.not(
      id: Reservation.where(
        'start_date <= ? AND end_date > ?', date, date
      ).select(:accommodation_id)
    )
  }
end
