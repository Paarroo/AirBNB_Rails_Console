class City < ApplicationRecord
  validates :name,
    presence: true,
    uniqueness: true

  validates :zip_code,
    presence: true,
    uniqueness: { case_sensitive: false },
    format: { with: /\A(([0-8][0-9])|(9[0-5])|(2[ab]))[0-9]{3}\z/, message: "Please enter a valid french zip code" }

  has_many :accommodations, dependent: :destroy
end
