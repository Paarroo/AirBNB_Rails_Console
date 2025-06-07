class User < ApplicationRecord
  has_many :reservations, foreign_key: 'guest_id', dependent: :destroy
  has_many :accommodations, foreign_key: 'owner_id', dependent: :destroy

  validates :email,
    presence: true,
    uniqueness: { case_sensitive: false },
    format: {
      with: /\A[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\z/,
      message: "Email should be a valid email!"
    }

  validates :phone,
    presence: true,
    uniqueness: true,
    format: {
      with: /\A(?:(?:\+|00)33[\s.-]{0,3}(?:\(0\)[\s.-]{0,3})?|0)[1-9](?:(?:[\s.-]?\d{2}){4}|\d{2}(?:[\s.-]?\d{3}){2})\z/,
      message: "Please enter a valid French number"
    }
end
