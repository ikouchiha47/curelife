class Doctor < ApplicationRecord
	has_secure_password

	validates :password, presence: true, on: :create
	validates :name, :phone, :country_code, presence: true

	validates :country_code, numericality: {in: 0..999}, allow_blank: true
	validates_format_of :phone, :with => /[0-9]{10,}/, allow_blank: true

    validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/ }
    validates :registration_number, presence: true, uniqueness: true

    def self.at_location

    end
end
