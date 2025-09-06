class User < ApplicationRecord
  has_many :reservations, foreign_key: 'guest_id', dependent: :destroy
  has_many :accommodations, foreign_key: 'owner_id', dependent: :destroy

  validates :email,
    presence: true,
    uniqueness: { case_sensitive: false },
    format: {
      with: /\A[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\z/,
      message: "Email should be a valid email!"
    },
    length: { maximum: 255 }

  validates :phone,
    presence: true,
    uniqueness: true,
    format: {
      with: /\A(?:(?:\+|00)33[\s.-]{0,3}(?:\(0\)[\s.-]{0,3})?|0)[1-9](?:(?:[\s.-]?\d{2}){4}|\d{2}(?:[\s.-]?\d{3}){2})\z/,
      message: "Please enter a valid French number"
    }

  # Normalize email before saving
  before_save :normalize_email

  def full_accommodations_count
    accommodations.count
  end

  def total_reservations_count
    reservations.count
  end

  def is_host?
    accommodations.any?
  end

  def is_guest?
    reservations.any?
  end

  def upcoming_reservations
    reservations.where('start_date > ?', Date.current)
  end

  def past_reservations
    reservations.where('end_date < ?', Date.current)
  end

  # Display helpers for console
  def full_name
    # Generate a display name from email since we don't have first_name/last_name
    email.split('@').first.capitalize
  end

  def phone_number
    phone
  end

  def to_s
    if Rails.env.development? && defined?(String.new.colorize)
      "👤 #{full_name} (#{email})".colorize(:purple)
    else
      "#{full_name} (#{email})"
    end
  end

  def inspect
    if Rails.env.development?
      to_s
    else
      super
    end
  end

  private

  def normalize_email
    self.email = email.downcase.strip if email.present?
  end
end
